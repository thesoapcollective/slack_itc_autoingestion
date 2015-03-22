class SlackItcAutoingestion::SlackController < ApplicationController

  protect_from_forgery with: :null_session

  def receiver
    slack = SlackItcAutoingestion::Slack.new params

    if slack.valid?
      autoingestion = SlackItcAutoingestion::ItunesConnect.new(
        SlackItcAutoingestion.configuration.itc_username,
        SlackItcAutoingestion.configuration.itc_password,
        SlackItcAutoingestion.configuration.itc_vendor_id
      )
      autoingestion.fetch_and_parse slack.report_params

      uri = URI.parse SlackItcAutoingestion.configuration.slack_webhook_url
      http = Net::HTTP.new uri.host, uri.port
      http.use_ssl = true

      request = Net::HTTP::Post.new uri.request_uri
      body = {
        username: 'Itunes Connect Autoingestion',
        icon_url: view_context.image_url('slack_itc_autoingestion/itunesconnect_app_icon.png'),
        attachments: [{
          fallback: slack.fallback(autoingestion.report),
          title: slack.title(autoingestion.report),
          fields: slack.fields(autoingestion.report),
          color: '#0594f9'
        }]
      }
      request.body = body.to_json
      response = http.request request

      render json: {}, status: :ok
    else
      render json: {error: {message: slack.error_message}}, status: :bad_request
    end
  end

end

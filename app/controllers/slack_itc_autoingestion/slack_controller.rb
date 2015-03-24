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

      uri = URI.parse SlackItcAutoingestion.configuration.slack_webhook_url
      http = Net::HTTP.new uri.host, uri.port
      http.use_ssl = true
      request = Net::HTTP::Post.new uri.request_uri

      body = {
        username: 'Itunes Connect Autoingestion',
        icon_url: view_context.image_url('slack_itc_autoingestion/itunesconnect_app_icon.png')
      }

      begin
        slack.report = autoingestion.fetch_and_parse slack.report_params
        body[:text] = slack.text
        body[:attachments] = slack.attachments
      rescue => e
        body[:text] = e.message
      end

      request.body = body.to_json
      response = http.request request

      render json: {}, status: :ok
    else
      render json: {error: {message: slack.error_message}}, status: :bad_request
    end
  end

end

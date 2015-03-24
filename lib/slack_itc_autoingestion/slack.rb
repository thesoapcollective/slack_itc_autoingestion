module SlackItcAutoingestion
  class Slack

    DATE_FORMAT = '%a, %b %-m, %Y'
    ATTACTMENT_COLOR = '#0594f9'

    attr_accessor :report
    attr_reader :report_params

    def initialize(params = {})
      @command = params[:command]
      @token = params[:token]
      @report_params = parse_text params[:text]
    end

    def parse_text(text)
      data = {}
      args = text.split(' ')
      data[:report_date] = args[0] if args[0]
      data[:date_type] = args[1].capitalize if args[1]
      data[:report_type] = args[2].titleize.gsub(' ', '-') if args[2]
      data
    end

    def error_message
      if !valid_command?
        "Invalid Slack command received. Got '#{@command}' and expected '#{SlackItcAutoingestion.configuration.slack_command}'."
      elsif !valid_token?
        "Invalid Slack token received."
      end
    end

    def valid?
      valid_command? && valid_token?
    end

    def valid_command?
      @command == SlackItcAutoingestion.configuration.slack_command
    end

    def valid_token?
      @token == SlackItcAutoingestion.configuration.slack_token
    end

    def text
      "Units sold #{date_text}."
    end

    def attachments
      slack_attachments = []
      grouped_skus = @report.group_by { |i| i[:sku] }
      products = grouped_skus.select { |_, skus| skus[0][:parent_id].empty? }
      iaps = grouped_skus.select { |_, skus| skus[0][:parent_id].present? }

      products.each do |sku_id, skus|
        units = skus.reduce(0) {|sum, sku| sum + sku[:units] }
        sku_iaps = iaps.select { |_, iap| iap[0][:parent_id] == sku_id }

        slack_attachments.push({
          fallback: fallback(units),
          title: skus[0][:title],
          text: "#{units} units sold.",
          fields: fields(sku_iaps),
          color: ATTACTMENT_COLOR
        })
      end

      slack_attachments
    end

    def fallback(units)
      "#{units} units sold #{date_text}."
    end

    def fields(iaps)
      slack_fields = []

      iaps.each do |_, skus|
        slack_fields.push({
          title: skus[0][:title],
          value: skus.reduce(0) {|sum, sku| sum + sku[:units] },
          short: true
        })
      end

      slack_fields
    end

    def date_text
      item = @report.first
      begin_date = item[:begin_date]
      end_date = item[:end_date]

      if begin_date == end_date
        "on #{formatted_date(begin_date)}"
      else
        "between #{formatted_date(begin_date)}-#{formatted_date(end_date)}"
      end
    end

    def formatted_date(date)
      date.strftime DATE_FORMAT
    end

  end
end

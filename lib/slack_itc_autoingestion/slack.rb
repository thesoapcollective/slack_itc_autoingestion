module SlackItcAutoingestion
  class Slack

    DATE_FORMAT = '%a, %b %-m, %Y'

    attr_reader :report_params

    def initialize(params = {})
      @command = params[:command]
      @token = params[:token]
      @report_params = {}
      @report_params[:date_type] = params[:date_type] if params[:date_type].present?
      @report_params[:report_type] = params[:report_type] if params[:report_type].present?
      @report_params[:report_date] = params[:report_date] if params[:report_date].present?
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

    def fallback(report)
      units = report.reduce(0) {|sum, d| sum + d[:units] }
      "Units sold #{date_text(report)} was #{units}."
    end

    def title(report)
      "Units sold #{date_text(report)}."
    end

    def fields(report)
      skus = report.group_by { |v| v[:sku] }
      sku_fields = []
      skus.each do |k, v|
        sku_fields.push ({
          title: k,
          value: v.reduce(0) {|sum, d| sum + d[:units] },
          short: true
        })
      end
      sku_fields
    end

    def date_text(report)
      item = report.first
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

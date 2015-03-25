module SlackItcAutoingestion
  class Configuration

    attr_accessor :itc_username
    attr_accessor :itc_password
    attr_accessor :itc_vendor_id
    attr_accessor :slack_token
    attr_accessor :slack_webhook_url
    attr_accessor :slack_command

    def initialize
      @itc_username = ENV['ITUNES_CONNECT_USERNAME']
      @itc_password = ENV['ITUNES_CONNECT_PASSWORD']
      @itc_vendor_id = ENV['ITUNES_CONNECT_VENDOR_ID']
      @slack_token = ENV['SLACK_TOKEN']
      @slack_webhook_url = ENV['SLACK_WEBHOOK_URL']
      @slack_command = '/itc'
    end

  end

  class << self
    attr_accessor :configuration

    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield configuration
    end
  end
end

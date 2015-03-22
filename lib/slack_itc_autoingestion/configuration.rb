module SlackItcAutoingestion
  class Configuration

    attr_accessor :itc_username
    attr_accessor :itc_password
    attr_accessor :itc_vendor_id
    attr_accessor :slack_token
    attr_accessor :slack_webhook_url
    attr_accessor :slack_command

    def initialize
      @itc_username = nil
      @itc_password = nil
      @itc_vendor_id = nil
      @slack_token = nil
      @slack_webhook_url = nil
      @slack_command = '/itc'
    end

  end

  class << self
    attr_accessor :configuration

    def configure
      self.configuration ||= Configuration.new
      yield configuration
    end
  end
end

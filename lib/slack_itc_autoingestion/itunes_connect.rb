require 'itunes_ingestion'

module SlackItcAutoingestion
  class ItunesConnect

    attr_reader :report

    def initialize(username, password, vid)
      @fetcher = ITunesIngestion::Fetcher.new username, password, vid
    end

    def fetch_and_parse(options = {})
      fetch options
      parse @report_data
    end

    def fetch(options = {})
      @report_options = options
      @report_data = @fetcher.fetch options
    end

    def parse(data)
      @report = ITunesIngestion::SalesReportParser.parse data
    end

  end
end

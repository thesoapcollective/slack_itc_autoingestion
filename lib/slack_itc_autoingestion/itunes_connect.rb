require 'itunes_ingestion'

module SlackItcAutoingestion
  class ItunesConnect

    def initialize(username, password, vid)
      @fetcher = ITunesIngestion::Fetcher.new username, password, vid
    end

    def fetch(options = {})
      @fetcher.fetch options
    end

    def parse(data)
      ITunesIngestion::SalesReportParser.parse data
    end

  end
end

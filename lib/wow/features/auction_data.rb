module WoW
  class AuctionData
    include HTTParty
    base_uri "#{WoW.host}/api/wow/auction/data"

    attr_reader :server, :last_modified, :url

    def initialize(server, params = {})
      response = self.class.data(server, params)

      # Only use the first file for now...
      file = response["files"][0]

      @server        = server
      @last_modified = Time.at(file["lastModified"].to_i / 1000)
      @url           = file["url"]
    end

    def data
      HTTParty.get(@url).parsed_response
    end

    class << self
      def data(server, params = {})
        params.merge!({locale: WoW.locale})
        get("/#{server}", query: params).parsed_response
      end
    end
  end
end

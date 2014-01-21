module WoW
  class Leaderboard < Base
    include HTTParty
    base_uri "#{WoW.host}/api/wow/leaderboard"

    def initialize(bracket, params = {})
      super(self.class.data(bracket, params))
    end

    class << self
      def data(bracket, params = {})
        params.merge!({locale: WoW.locale})
        get("/#{bracket}", query: params).parsed_response
      end
    end
  end
end

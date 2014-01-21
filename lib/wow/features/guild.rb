module WoW
  class Guild < Base
    include HTTParty
    base_uri "#{WoW.host}/api/wow/guild"

    def initialize(realm, guild_name, fields = [], params = {})
      params = params.merge({fields: fields.join(',')})
      super(self.class.data(realm, guild_name, params))
    end

    class << self
      def data(realm, guild_name, params = {})
        params.merge!({locale: WoW.locale})
        get("/#{realm}/#{guild_name}", query: params).parsed_response
      end
    end
  end
end

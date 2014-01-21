module WoW
  class Recipe < Base
    include HTTParty
    base_uri "#{WoW.host}/api/wow/recipe"

    def initialize(id, params = {})
      params = params.merge({fields: fields.join(',')})
      super(self.class.data(id, params))
    end

    class << self
      def data(id, params = {})
        params.merge!({locale: WoW.locale})
        get("/#{id}", query: params).parsed_response
      end
    end
  end
end

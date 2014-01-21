module WoW
  class Item < Base
    include HTTParty
    base_uri "#{WoW.host}/api/wow/item"

    def initialize(id, params = {})
      super(self.class.data(id, params))
    end

    class << self
      def data(id, params = {})
        params.merge!({locale: WoW.locale})
        get("/#{id}", query: params).parsed_response
      end
    end
  end

  class Item::Set < Base
    include HTTParty
    base_uri "#{WoW.host}/api/wow/item/set"

    def initialize(id, params = {})
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

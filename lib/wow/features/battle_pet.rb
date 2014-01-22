module WoW
  module BattlePet

    class Ability < Base
      base_uri "#{WoW.host}/api/wow/battlePet/ability"

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

    class Species < Base
      base_uri "#{WoW.host}/api/wow/battlePet/species"

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

    class Stats < Base
      base_uri "#{WoW.host}/api/wow/battlePet/stats"

      # This API accepts optional parameters.
      #
      # :level (default 1)
      # :breedId (default 3)
      # :qualityId (default 1)
      #
      # For example:
      #
      # WoW::BattlePet::Stats.new(132, level: 10)
      #
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
end

module WoW
  module ChallengeMode

    class Realm
      include HTTParty
      base_uri "#{WoW.host}/api/wow/challenge"

      def initialize(realm, params = {})
        params = params.merge({locale: WoW.locale})
        #...
      end

    end

    class Region < Realm
      def initialize(params = {})
        # super...
      end
    end

  end
end

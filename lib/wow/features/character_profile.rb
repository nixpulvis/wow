module WoW
  class CharacterProfile < Base
    CLASSES = {
      1  => :warrior,
      2  => :paladin,
      3  => :hunter,
      4  => :rogue,
      5  => :priest,
      6  => :death_knight,
      7  => :shaman,
      8  => :mage,
      9  => :warlock,
      10 => :monk,
      11 => :druid,
    }

    base_uri "#{WoW.host}/api/wow/character"

    def initialize(realm, character_name, fields = [], params = {})
      if realm.to_s.empty?
        raise WoW::APIError.new "Realm cannot be blank"
      end
      if character_name.to_s.empty?
        raise WoW::APIError.new "Character name cannot be blank"
      end

      params = params.merge({fields: fields.join(',')})
      super(self.class.data(realm, character_name, params))
    end

    def lookup(key)
      case key
      when :class
        CLASSES[self[key]]
      else
        raise "No lookup mapping for #{key}"
      end
    end

    class << self
      def data(realm, character_name, params = {})
        params.merge!({locale: WoW.locale})
        get("/#{CGI::escape(realm)}/#{CGI::escape(character_name)}",
          query: params).parsed_response
      end
    end
  end
end

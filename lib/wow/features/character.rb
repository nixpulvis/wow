module WoW
  class Character < Base
    CLASSES = {
      1  => "warrior",
      2  => "paladin",
      3  => "hunter",
      4  => "rogue",
      5  => "priest",
      6  => "death_knight",
      7  => "shaman",
      8  => "mage",
      9  => "warlock",
      10 => "monk",
      11 => "druid",
    }

    base_uri "#{WoW.host}/api/wow/character"

    def initialize(realm, character_name, fields = [], params = {})
      if realm.to_s.empty?
        raise ArgumentError.new("realm cannot be blank")
      end
      if character_name.to_s.empty?
        raise ArgumentError.new("character name cannot be blank")
      end

      params = params.merge({fields: fields.join(',')})
      data = self.class.data(realm, character_name, params)

      if data.empty?
        raise APIError, "Character not active."
      end

      super(data)
    end

    class << self
      def data(realm, character_name, params = {})
        params.merge!({locale: WoW.locale})
        get("/#{CGI::escape(realm)}/#{CGI::escape(character_name)}",
          query: params).parsed_response
      end
    end

    private

    def get_class
      CLASSES[self["class"]]
    end

    def get_active_spec
      unless self["talents"]
        raise FieldMissingError.new("missing field \"talents\"")
      end

      self["talents"].detect { |t| t["selected"] }
    end

    def get_inactive_spec
      unless self["talents"]
        raise FieldMissingError.new("missing field \"talents\"")
      end

      self["talents"].detect { |t| !t["selected"] }
    end

    def get_thumbnail
      "http://us.battle.net/static-render/us/#{self["thumbnail"]}"
    end

  end
end

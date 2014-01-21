module WoW
  class Base < Hash

    def initialize(data)
      data.each { |k,v| self[k] = v }

      if self["status"] == "nok"
        raise APIError.new(self["reason"])
      end
    end

    def [](key)
      super(key.to_sym)
    end

    def []=(key, value)
      super(key.to_sym, value)
    end

  end
end

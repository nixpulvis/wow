require "cgi"

module WoW
  class Base < Hash
    include HTTParty

    def initialize(data)
      data.each { |k,v| self[k] = v }

      if self["status"] == "nok"
        raise APIError.new(self["reason"])
      end
    end

    def gets
      private_methods.select { |m| m =~ /get_/ }.map do |name|
        name.to_s.gsub(/get_/, "")
      end
    end

    def get(method)
      self.send("get_#{method}")
    end

    def get?(method)
      gets.include?(method)
    end
  end
end

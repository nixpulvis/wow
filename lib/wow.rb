require 'httparty'

require 'wow/version'
require 'wow/base'

module WoW
  class ConfigurationError < StandardError; end
  class APIError < StandardError; end

  # Blizzard defined hosts, and locales.
  # See http://blizzard.github.io/api-wow-docs/#features/access-and-regions

  LOCALIZATIONS = {
    'us.battle.net' => ['en_US', 'es_MX', 'pt_BR'],
    'eu.battle.net' => ['en_GB', 'es_ES', 'fr_FR', 'ru_RU', 'de_DE', 'pt_PT', 'it_IT'],
    'kr.battle.net' => ['ko_KR'],
    'tw.battle.net' => ['zh_TW'],
    'www.battlenet.com.cn' => ['zh_CN'],
  }

  # Set defaults.
  @host   = 'us.battle.net'
  @locale = 'en_US'

  class << self
    attr_reader :locale, :host

    def locale=(value)
      if LOCALIZATIONS[@host].include?(value)
        @locale = value
      else
        raise ConfigurationError.new("Bad locale \"#{value}\" for host #{@host}.")
      end
    end

    def host=(value)
      if LOCALIZATIONS.has_key?(value)
        @host = value
      else
        raise ConfigurationError.new("Bad host \"#{value}\".")
      end
    end

    def configuration
      yield self
    end
  end
end

require 'wow/features'

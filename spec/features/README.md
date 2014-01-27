# WoW

Ruby API wrapper for Blizzards [WoW API](http://blizzard.github.io/api-wow-docs/).

## Ideology

This library exists for 2 purposes.

1. Direct one-to-one mapping of the WoW API to a ruby hash.
2. Defined helper functions to help accessing data.

### Object Instantiation

Every endpoint of the WoW API has a class. For example `WoW::Character` is the class representing the endpoint of `http://us.battle.net//api/wow/character/`. The name of the class is the CamelCased equivalent of the endpoint name. `http://us.battle.net//api/wow/battlePet/` for example is `WoW::BattlePet`.

The initializer function for the class takes as many *non-blank* arguments as the WoW API requires.

For example, the API dictates the following URL structure for a character.
```
URL = Host + "/api/wow/character/" + Realm + "/" + CharacterName
```

so the Ruby syntax is
```ruby
WoW::Character.new(realm, character_name)
```

Additionally if there are optional fields then they can be requested by passing an array as the third argument.
```ruby
WoW::Character.new(realm, character_name, [:items, :talents])
```

Other params may be specified as a hash in the fourth argument.
```ruby
WoW::Character.new(realm, character_name, locale: "es_MX")
WoW::Character.new(realm, character_name, [:items, :talents], locale: "es_MX")
```

### Object Attribute Access

Accessing the data from the object is very simple. Each object subclasses from the ruby `Hash` so access is done on the object as a hash.

```ruby
character["achievementPoints"]          #=> 13450
character["items"]["averageItemLevel"]  #=> 573
```
**Note:** Attribute access is only done through string keys.

### Object Methods

Sometimes the WoW API itself makes getting the data we want harder than we'd like, in these cases this wrapper attempts to help. To keep the API of this wrapper as simple as possible we only define 3 functions.

```ruby
# Character#gets          #=> Array ["class", "active_spec"]
# Character#get(String)   #=> Value, ex get("class") might return "druid"
# Character#get?(String)  #=> Boolean true if object can `get` on the given string.
```

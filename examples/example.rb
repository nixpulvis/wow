require "wow"

epicgrim = WoW::Character.new("Stormreaver", "Epicgrim", [:items, :talents])
puts epicgrim["achievementPoints"]
puts epicgrim["items"]["averageItemLevelEquipped"]
p epicgrim.gets
puts epicgrim.get?("class")
puts epicgrim.get("class")

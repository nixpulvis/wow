require "wow"

# 25.times do |i|
#   begin
#     achive = WoW::Achievement.new(i)
#     puts "#{achive[:id]} : #{achive[:title]}"
#   rescue WoW::APIError
#     puts "#{i} : No Achievement"
#   end
# end

puts WoW::CharacterProfile.new("Stormreaver", "Epicgrim").lookup(:class)

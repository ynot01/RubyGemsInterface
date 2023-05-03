require 'colorize'
require 'json'
require 'net/http'
require_relative "truncate"
require_relative "search"
require_relative "listing"

def run()
  puts "#{"Commands (0-3):".blue}
[0] #{"Exit".yellow}
[1] #{"View recently added gems".green}
[2] #{"View recently updated gems".green}
[3] #{"Search gems".green}"

  input = gets.to_i
  case input
  when 0
    puts "Closing...".yellow
  when 1
    listing(JSON.parse(Net::HTTP.get(URI("https://rubygems.org/api/v1/activity/latest"))).take(12))
  when 2
    listing(JSON.parse(Net::HTTP.get(URI("https://rubygems.org/api/v1/activity/just_updated"))).take(12))
  when 3
    puts "Search: ".yellow
    search(gets)
  else
    puts "Invalid command, closing...".red
  end
end
run()

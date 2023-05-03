def search(term)
  if term.strip.length == 0
    puts "Invalid search term, returning to menu...".red
    run()
    return
  end
  results = JSON.parse(Net::HTTP.get(URI("https://rubygems.org/api/v1/search.json?query=#{term}"))).take(12)
  if results.length == 0
    puts "No gems found!".red
    run()
    return
  end
  listing(results)
end

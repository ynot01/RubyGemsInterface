def listing(results)
  puts "Select a gem:".yellow
  count = 1
  puts "[0] #{"Back".yellow}"
  results.each do |item|
    puts truncate("[#{count}] #{item["name"].green}: #{item["info"].gsub("\n", " ")}", 160)
    count += 1
  end
  input = gets.to_i
  if input === 0
    run()
    return
  elsif input > 13 || input < 0
    puts "Invalid selection!".red
    listing(results)
    return
  else
    selected = JSON.parse(Net::HTTP.get(URI("https://rubygems.org/api/v1/gems/#{results[input-1]["name"]}.json")))
    puts selected["name"].green
    puts "Downloads: #{selected["downloads"]}".blue
    puts "Version #{selected["version"]}".blue
    puts "Authors: #{selected["authors"]}".blue
    puts "Description: #{selected["info"]}".blue
    puts "Link: #{selected["project_uri"]}".blue
    puts "Source Code: #{selected["source_code_uri"]}".blue
    puts "Docs: #{selected["documentation_uri"]}".blue
    puts "Enter \"get\" to install this gem or anything else to go back...".yellow
    input = gets.to_s
    if input.strip === "get"
      puts "Installing #{selected["name"]}...".yellow
      system("gem install #{selected["name"]}")
      puts "Press enter to continue...".yellow
      gets
    end
    listing(results)
  end
end

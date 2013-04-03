#!/usr/bin/env ruby -wKU
require "open-uri"
require "sqlite3"

puts "Swiper, no swiping!"
puts "..."

image_urls = []

image_file = File.new( ARGV.first, "r" )
image_file.each_line do |line|
  puts "URL: #{line}"
  image_urls << line.delete( "\n" ) 
end

db = SQLite3::Database.open( "directory_data.db" )

# Get the images and save them into this script's directory.
image_urls.each do |url|

  name = url.split "/"
  file_name = name.last.inspect.gsub!(/"/, "").gsub!(/-iGrow/, "")

  last, first, file_extension = file_name.split( "." )
  person_info = db.get_first_row( "SELECT _id, last_name, first_name_pref FROM People WHERE last_name = ? AND first_name_pref = ?", [last, first] )
  puts person_info
  person_id = person_info.first
  # Write contents to file_name
  file_name = person_id.to_s << "." << file_extension
  puts file_name
  # 
  open( file_name, 'wb' ) do |file|
    file << open(url).read  
  end
    
end

# When we're done, close the database object.
db.close unless db.closed?

# if $stderr
#   puts "Swiper, no swiping! Swiper, no swiping!"
#   puts "Ohhh, man!"
# end
puts "You're too late! You'll never find your images now!"

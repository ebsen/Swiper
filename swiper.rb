#!/usr/bin/env ruby -wKU
require "open-uri"
require "sqlite3"

# puts "Swiper, no swiping!"
# puts "..."

# Set up local variables.
image_urls = []
image_file = File.new( ARGV.first, "r" )
db = SQLite3::Database.open( "directory_data.db" )

puts "Oh no, Boots! Swiper wants to steal our images from the following URLs!"
image_file.each_line do |line|
  puts "URL: #{line}"
  image_urls << line.delete( "\n" ) 
end

# Try to swipe the images and stash them into this script's directory.
image_urls.each do |url|

  # Break down the url into first name, last name, and file extension.
  name = url.split( "/" )
  file_name = name.last.inspect.gsub!(/"/, "").gsub!(/-iGrow/, "")
  last, first, file_extension = file_name.split( "." )

  # Get the ID number from the database that matches this person.
  person_id = db.get_first_value( "SELECT _id FROM People WHERE last_name = ? AND first_name_pref = ?", [last, first] )
  
  # Build the image's file name.
  file_name = person_id.to_s << "." << file_extension

  # Create/open a file by that name and write the image from the url to it.
  open( file_name, 'wb' ) do |file|
    file << open(url).read  
  end
    
end

# When we're done, close the database object.
db.close unless db.closed?

puts "You're too late! You'll never find your images now!"

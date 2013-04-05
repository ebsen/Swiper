#!/usr/bin/env ruby -wKU
require "open-uri"
require "sqlite3"

# Introduction
puts "\n\"Oh no! Swiper wants to steal our photos!\""; puts

# Set up some handy local variables.
db                   = SQLite3::Database.open( "sample_data.db" )
db.results_as_hash   = true
file_extension       = "jpg"
peeps_without_images = []

# Scan each row of the database for images to swipe.
db.execute( "SELECT _id, last_name, first_name_pref, photo FROM People" ) do |row|
  name = "#{row['first_name_pref']} #{row['last_name']}"
  print "Swiping %s's photo..." % name
    
  # Swipe the URL of the image.
  if row['photo'].nil? or row['photo'].eql? ""
    url = "http://igrow.org/up/authors/LAST.FIRST-iGrow.jpg".gsub!( /LAST/, row['last_name'] ).gsub!( /FIRST/, row['first_name_pref'] )
  else
    url = row['photo']
  end
  
  begin open(url)
  rescue
    puts; puts "--Failed to swipe #{url}" 
    peeps_without_images << name
    next
  end
 
  # Build a file name to use for the image.
  file_name = row['_id'].to_s << "." << file_extension

  # Create/open a file by that name and write the image from the URL to it.
  open( file_name, 'wb' ) do |file|
    file << open(url).read  
  end
  
  # Update the row in the database with the filename to use in the app.
  db.execute( "UPDATE People SET photo = '#{row['_id'].to_s + ".png"}' WHERE _id = #{row['_id']}" )
  
  print "swiped.\n"

end

# When we're done, make sure we close the database object.
db.close unless db.closed?

# Relish in our success.
puts; puts "You're too late! You'll never find your images now!"
 
# ...and note our failures.
puts; puts "These folks haven't an image yet:"
peeps_without_images.each do |peep|
  puts peep
end

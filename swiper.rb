#!/usr/bin/env ruby -wKU
require "open-uri"
require "sqlite3"

# Introduction
puts "\"Oh no! Swiper wants to steal our photos!\""

# Set up some handy local variables.
db                 = SQLite3::Database.open( "directory_data.db" )
db.results_as_hash = true
file_extension     = "jpg"

# Scan each row of the database for images to swipe.
db.execute( "SELECT _id, first_name_pref, photo FROM People" ) do |row|
  unless row['photo'].nil?
    print "(Swiping %s's photo..." % row['first_name_pref']
    
    # Swipe the URL of the image.
    url = row['photo']
  
    # Build the image's file name.
    file_name = row['_id'].to_s << "." << file_extension

    # Create/open a file by that name and write the image from the URL to it.
    open( file_name, 'wb' ) do |file|
      file << open(url).read  
    end
    print "swiped.)\n"
  end
    
end

# When we're done, make sure we close the database object.
db.close unless db.closed?

# Relish in our success.
puts "You're too late! You'll never find your images now!"

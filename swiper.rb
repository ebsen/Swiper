#!/usr/bin/env ruby -wKU
require "open-uri"
require "sqlite3"

# Introduction
puts "\"Oh no! Swiper wants to steal our photos!\""

# Set up some handy local variables.
db                 = SQLite3::Database.open( "extension_data_2013-04-18.db" ) # Change this name as necessary.
db.results_as_hash = true
file_extension     = "jpg"

# Scan each row of the database for images to swipe.
db.execute( "SELECT _id, first_name_pref, photo FROM People" ) do |row|
  unless row['photo'].nil? or row['photo'].eql? ""
    # print "(Swiping %s's photo..." % row['first_name_pref']
    
    # Swipe the URL of the image.
    url = row['photo']
  
    # Build a file name to use for the image.
    # file_name = row['_id'].to_s << "." << file_extension
    file_name = row['last_name'].to_s + "_" + row['first_name_pref'].to_s + "-iGrow" + file_extension
    
    print "(Swiping photo: %s " % file_name
    
    # Check if our URL is valid, acknowledge the failure if it occurs, and move on.
    # begin open( url )
    # rescue
    #   puts "--Oh, man! (Failed to swipe #{url}.)"
    #   next
    # end

    # Create/open a file by that name and write the image from the URL to it.
    open( file_name, 'wb' ) do |file|
      file << open(url).read  
    # rescue
    #   puts "--Oh, man! (Failed to swipe.)"
    #   next
    end
    
    # Update the row in the database with the filename to use in the app.
    db.execute( "UPDATE People SET photo = '#{row['_id'].to_s + ".png"}' WHERE _id = #{row['_id']}" )
    
    print "swiped.)\n"
    
  end  
end

# When we're done, make sure we close the database object.
db.close unless db.closed?

# Relish in our success.
puts "You're too late! You'll never find your images now!"

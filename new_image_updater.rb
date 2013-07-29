#!/usr/bin/env ruby -wKU

require "sqlite3"

# Set up some handy local variables.
db             = SQLite3::Database.open "extension_data_2013-04-18.db"
file_extension = "jpg"

new_images = [
  # "Aragon_Martha-iGrow.jpg", "Atteberry_Lucy-iGrow.jpg", "Bauman_Pete-iGrow.jpg", "Bear_Rhonda-iGrow.jpg", "Bowman_Donnette-iGrow.jpg", "Brown_Leacey-iGrow.jpg", "Burrows_Rhonda-iGrow.jpg", "Byamukama_Emmanuel-iGrow.jpg", 
  # "Carlson_Greg-iGrow.jpg", 
  # "Chalmers_David-iGrow.jpg", 
  # "Dalton_Kathleen-iGrow.jpg", 
  # "Elliott_Lisa-iGrow.jpg", "Ellis_Roger-iGrow.jpg", "Estes_Joshua-iGrow.jpg", "Farrand_Karelyn-iGrow.jpg", "Ferguson_Keith-iGrow.jpg", "Fryer_Darbee-iGrow.jpg", "Green_John-iGrow.jpg", "Grings_Elaine-iGrow.jpg", "Hadi_Buyung-iGrow.jpg", "Hardin_Cheryl-iGrow.jpg", "Harty_Adele-iGrow.jpg", "HerManyHorses_Kathi-iGrow.jpg", "Jensen_Becky-iGrow.jpg", "Johnson_Carrie-iGrow.jpg", "Keimig_John-iGrow.jpg", "Kincheloe_Janna-iGrow.jpg", "Kittelson_Davita-iGrow.jpg", "Klein_Sharon-iGrow.jpg", "Knippling_Matthew-iGrow.jpg", "Koepke_Sara-iGrow.jpg", "Lehrke_Tracey-iGrow.jpg", "Lindvall_Rachel-iGrow.jpg", "Mack_Sonia-iGrow.jpg", "Malo_Doug-iGrow.jpg", "Malson_Jennifer-iGrow.jpg", "Martinell_Charles-iGrow.jpg", "McDaniel_Kaycee-iGrow.jpg", "Modica_Mary-iGrow.jpg", "Morse_Paulette-iGrow.jpg", "Mueller_Nathan-iGrow.jpg", "Njue_Geoffrey-iGrow.jpg", 
  # "O'Neill_Kari-iGrow.jpg", # Dunno why this one failed
  "Ollila_Dave-iGrow.jpg", "Oscarson_Renee-iGrow.jpg", "Pearl_Deb-iGrow.jpg", "Phillips_Becky-iGrow.jpg", "Quade_Linda-iGrow.jpg", "Reif_Alicia-iGrow.jpg", "Ringkob_Jennifer-iGrow.jpg", "Roseland_Kelly-iGrow.jpg", "Ross_Randy-iGrow.jpg", "Rounds_Jan-iGrow.jpg", "Sand_Shannon-iGrow.jpg", "Sanders_John-iGrow.jpg", "Schumacher_Evonne-iGrow.jpg", "Schwader_Ann-iGrow.jpg", "Sherin_Kenneth-iGrow.jpg", "Simon-Deon-iGrow.jpg", "Stluka_Suzanne-iGrow.jpg", "Suderman_Barb-iGrow.jpg", "Thares_Paul-iGrow.jpg", "Trautman_Karla-iGrow.jpg", "Tullar_Becca-iGrow.jpg", "Underwood_Keith-iGrow.jpg", "Ungemeier_Tacy-iGrow.jpg", "Van_Dyke_Nikki-iGrow.jpg", "VanderWal_Kevin-iGrow.jpg", "Vigdal_Deb-iGrow.jpg", "Waters_Kalyn-iGrow.jpg", "Weller_Carrie-iGrow.jpg", "Welter_Misty-iGrow.jpg", "Whitlock_Rebecca-iGrow.jpg", "Wilson-Sweebe_Kimberly-iGrow.jpg"
]

new_images.each do |file_name|
  
  # person_id = String.new
  last_name, rest_of_name = file_name.split "_"
  person_id = db.get_first_value( "SELECT _id FROM People WHERE last_name = '%s'" % last_name ).to_s
  
  puts "Person: #{last_name}, #{person_id}"
  # new_file_name = person_id.to_s + ".png"

  # Update the database.
  db.execute "UPDATE People SET photo = '#{person_id + ".png"}' WHERE last_name = '#{last_name}'"

  # Update the file name.
  begin
    File.rename file_name, person_id
  rescue Exception => e
    puts e.message
    next
  end
end

db.close unless db.closed?

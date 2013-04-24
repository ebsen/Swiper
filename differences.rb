# Simple script to compare revisions of the database, looking for people who had image URLs added.
original_list = IO.read "listOfPeopleWithPhoto.txt"
new_list = open "newListOfPeopleWithPhoto.txt"
new_list.each do |line|
  unless original_list.include? line
    puts line
  end
end
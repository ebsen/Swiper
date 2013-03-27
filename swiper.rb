#!/usr/bin/env ruby -wKU
require "open-uri"

puts "Swiper, no sw--!"
puts "..."

# open('image.png', 'wb') do |file|
#   file << open('http://igrow.org/up/authors/Dunn.Barry-iGrow.jpg').read
# end

images = [
  'http://igrow.org/up/authors/Dunn.Barry-iGrow.jpg',
  'http://igrow.org/up/authors/Burke.Shawn-iGrow.jpg',
  'http://igrow.org/up/authors/Edwards.Laura-iGrow.jpg',
  'http://igrow.org/up/authors/Salverson.Robin-iGrow.jpg'
]

images.each do |url|
  name = url.split "/"
  file_name = name.last.inspect.gsub!(/"/, "").gsub!(/-iGrow/, "")
  open( file_name, 'wb' ) do |file|
    file << open(url).read
  end
end

puts "You'll never find your images now!"

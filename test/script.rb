require File.expand_path('../../lib/gimlr.rb', __FILE__)

giml = File.expand_path('../test_file.giml', __FILE__)

puts Gimlr.parse_file(giml)

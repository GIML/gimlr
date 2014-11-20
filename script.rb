require File.expand_path('../../lib/gimlr.rb', __FILE__)
require 'yaml'
require 'byebug'
require 'benchmark/ips'
require 'ruby-prof'

path = File.expand_path('../test_file.giml', __FILE__)

path2 = File.expand_path('../test_file.yaml', __FILE__)

#puts GIMLR.parse_file(path)

Benchmark.ips do |x|
  x.config(time: 10, warmup: 5)
  x.report('gimlr') { Gimlr.parse_file(path) }
  x.report('yaml') { YAML.load_file(path2) }

  x.compare!
end

=begin
RubyProf.start
Gimlr.parse_file(path)
result = RubyProf.stop

printer = RubyProf::GraphHtmlPrinter.new(result)
printer.print(STDOUT)
=end

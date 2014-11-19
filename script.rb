require File.expand_path('../lib/gimlr.rb', __FILE__)
require 'yaml'
require 'byebug'
require 'benchmark/ips'
require 'ruby-prof'

path = File.expand_path('../test/test_file.giml', __FILE__)

path2 = File.expand_path('../test/test_file.yaml', __FILE__)

Benchmark.ips do |x|
  x.config(time: 10, warmup: 5)
  x.report('gimlr') { GIMLR.parse_file(path) }
  x.report('yaml') { YAML.load_file(path2) }

  x.compare!
end

=begin
RubyProf.start
GIMLR.parse_file(path)
result = RubyProf.stop

printer = RubyProf::GraphHtmlPrinter.new(result)
printer.print(STDOUT)
=end

require File.expand_path('../../lib/gimlr.rb', __FILE__)
require 'yaml'
require 'byebug'
require 'benchmark/ips'
require 'ruby-prof'
require 'toml'
require 'json'

giml = File.expand_path('../test_file.giml', __FILE__)

yaml = File.expand_path('../test_file.yaml', __FILE__)

toml = File.expand_path('../test_file.toml', __FILE__)

json = File.expand_path('../test_file.json', __FILE__)

Benchmark.ips do |x|
  x.config(time: 10, warmup: 5)
  content = File.read(json).freeze
  content1 = File.read(giml).freeze
  x.report('json') { JSON.parse(content) }
  x.report('gimlr') { Gimlr.parse_file(content1) }
  #x.report('yaml') { YAML.load_file(yaml) }
  #x.report('toml') { TOML.load_file(toml) }

  x.compare!
end

=begin
RubyProf.start
Gimlr.parse_file(path)
result = RubyProf.stop

printer = RubyProf::GraphHtmlPrinter.new(result)
printer.print(STDOUT)
=end

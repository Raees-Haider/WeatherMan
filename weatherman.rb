require 'optparse'
require 'date'
require_relative 'utils'
require_relative 'record'
require_relative 'parser'
require_relative 'report'

options = {}

opt = OptionParser.new do |o|
  o.banner = "Usage: ruby weatherman.rb [options] <weather_folder>"
  o.on("-e YEAR", "Show yearly extremes") { |v| options[:mode] = :year; options[:year] = v.to_i }
  o.on("-a Y/M", "Show monthly averages") { |v| options[:mode] = :avg; options[:ym] = v }
  o.on("-c Y/M", "Show monthly chart")    { |v| options[:mode] = :chart; options[:ym] = v }
  o.on("-b", "--combined", "Combined chart") { options[:combined] = true }
  o.on("-h", "--help") { puts o; exit }
end

opt.parse!
unless options[:mode]
  puts "Choose -e, -a, or -c"
  exit
end

path = ARGV.shift
unless path && Dir.exist?(path)
  puts "Invalid path"
  exit
end

parser = WeatherParser.new(path)
data = parser.read_all

if data.empty?
  puts "No valid weather data found."
  exit
end

if options[:mode] == :year
  YearlyReport.new(data, options[:year]).show
  exit
end

unless options[:ym] =~ /^(\d{4})\/?(\d{1,2})$/
  puts "Month must be YYYY/M or YYYY/MM"
  exit
end

yy, mm = $1.to_i, $2.to_i

case options[:mode]
when :avg
  MonthlyAverage.new(data, yy, mm).show
when :chart
  MonthlyChart.new(data, yy, mm, options[:combined]).show
end

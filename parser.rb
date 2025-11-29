require 'csv'
require_relative 'utils'
require_relative 'record'

class WeatherParser
  include Utils

  def initialize(path)
    @path = path
  end

  def read_all
    Dir.glob(File.join(@path, "**", "*.txt")).flat_map { |f| parse_file(f) }
  end

  private

  def keys
    {
      date: "PKT",
      max:  "Max TemperatureC",
      min:  "Min TemperatureC",
      hum:  "Max Humidity"
    }
  end

  def parse_file(file)
    raw = File.read(file).split("<").first
    csv = CSV.parse(raw, headers: true, skip_blanks: true)
    k = keys

    csv.filter_map do |r|
      date = parse_date(r[k[:date]])
      next unless date

      max = r[k[:max]]&.to_f&.round&.to_i
      min = r[k[:min]]&.to_f&.round&.to_i
      hum = r[k[:hum]]&.to_i

      WeatherRecord.new(date, max, min, hum) if max && min && hum
    end
  rescue
    []
  end
end

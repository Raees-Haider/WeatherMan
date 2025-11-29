require_relative 'utils'

class YearlyReport
  include Utils

  def initialize(data, year)
    @data = data.select { |r| r.date.year == year }
    @year = year
  end

  def show
    if @data.empty?
      puts "No data for year #{@year}"
      return
    end

    hot  = @data.max_by { |r| r.max }
    cold = @data.min_by { |r| r.min }
    hum  = @data.max_by { |r| r.hum }

    puts "Highest: #{hot.max}C on #{hot.date.strftime('%B %-d')}"
    puts "Lowest : #{cold.min}C on #{cold.date.strftime('%B %-d')}"
    puts "Humid  : #{hum.hum}% on #{hum.date.strftime('%B %-d')}"
  end
end

class MonthlyAverage
  include Utils

  def initialize(data, year, month)
    @rows = data.select { |r| r.date.year == year && r.date.month == month }
    @year = year
    @month = month
  end

  def show
    if @rows.empty?
      puts "No data for #{month_name(@year, @month)} #{@year}"
      return
    end

    maxs = @rows.map(&:max).compact
    mins = @rows.map(&:min).compact
    hums = @rows.map(&:hum).compact

    puts "Highest Average: #{avg(maxs)}C"
    puts "Lowest Average : #{avg(mins)}C"
    puts "Average Humidity: #{avg(hums)}%"
  end
end

class MonthlyChart
  include Utils

  def initialize(data, year, month, combined)
    @rows = data.select { |r| r.date.year == year && r.date.month == month }
    @year = year
    @month = month
    @combined = combined
  end

  def show
    if @rows.empty?
      puts "No data for #{month_name(@year, @month)} #{@year}"
      return
    end

    puts "\n #{month_name(@year, @month)} #{@year}"

    daily = @rows.group_by { |r| r.date.day }.transform_values do |list|
      {
        max: list.map(&:max).compact.max,
        min: list.map(&:min).compact.min
      }
    end

    daily.keys.sort.each do |d|
      mx = daily[d][:max]
      mn = daily[d][:min]
      next unless mx && mn
      day = "%02d" % d

      if @combined
        print "#{day} #{Utils::BLUE}" + "+" * mn
        print "#{Utils::RESET}#{Utils::RED}" + "+" * (mx - mn)
        puts "#{Utils::RESET} #{mn}C - #{mx}C"
      else
        puts "#{day} #{Utils::RED}#{'+' * mx}#{Utils::RESET} #{mx}C"
        puts "#{day} #{Utils::BLUE}#{'+' * mn}#{Utils::RESET} #{mn}C"
      end
    end
  end
end

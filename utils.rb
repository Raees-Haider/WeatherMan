module Utils
  RED  = "\e[31m"
  BLUE = "\e[34m"
  RESET = "\e[0m"

  def parse_date(s)
    return nil unless s&.strip&.match?(/\d{4}[-\/]\d{1,2}[-\/]\d{1,2}/)
    Date.parse(s.strip) rescue nil
  end

  def month_name(year, month)
    Date.new(year, month, 1).strftime("%B")
  end

  def avg(arr)
    return 0 if arr.empty?
    (arr.sum / arr.size.to_f).round
  end
end

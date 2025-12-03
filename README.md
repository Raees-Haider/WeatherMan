# WeatherMan
This is a Ruby-based command-line weather analysis tool that reads historical weather data files and generates yearly reports, monthly averages, and temperature charts. It parses weather records, processes max/min temperatures and humidity, and displays the results using colored terminal output.and provides:

- Yearly extreme weather reports
- Monthly average summaries
- Daily temperature charts (max/min)
- Optional combined bar charts

---

## 📌 Features

### ✔ Yearly Report (`-e`)
Shows the hottest, coldest, and most humid day of a selected year.

### ✔ Monthly Averages (`-a`)
Displays average max temperature, min temperature, and humidity for a specific month.

### ✔ Monthly Chart (`-c`)
Draws bar charts for each day:
- Red bars = Max temperature  
- Blue bars = Min temperature  
Supports combined mode using `-b`.

### ruby weatherman.rb -a 2005/6 Lahore_weather 
Highest Average: 42C  
Lowest Average : 27C  
Average Humidity: 58%  

### ruby weatherman.rb -e 2005 Lahore_weather  
Highest: 60C on June 1  
Lowest : 0C on December 14  
Humid  : 100% on August 11  


### ruby weatherman.rb -c 2005/6 Lahore_weather

 June 2005  
 01 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 60C  
 01 ++++++++++++++++++++++++ 24C  
 02 ++++++++++++++++++++++++++++++++++++++++++ 42C  
 02 ++++++++++ 10C  
 03 +++++++++++++++++++++++++++++++++++++++++++ 43C  
 03 +++++++++++++++++++++++++ 25C  


### ruby weatherman.rb -c 2005/6 -b Lahore_weather

 June 2005  
 01 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 24C - 60C   
 02 ++++++++++++++++++++++++++++++++++++++++++++++++++++ 10C - 42C   
 03 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 25C - 43C  

require 'httparty'
require 'pry'
class WeatherClient10Day
  include HTTParty
  base_uri 'api.wunderground.com/api/6fb454176eef8ba8'
  def initialize(state,city)
    @city = city
    @state = state
  end
  #http://api.wunderground.com/api/6fb454176eef8ba8/forecast10day/q/MD/Potomac.json
  def get_zip_code_weather
    self.class.get("/forecast10day/q/#{@state}/#{@city}.json")

  end

  def return_ten_day_weather
    result = get_zip_code_weather
    puts "ten day weather forcast"
    j = 1
    for i in (0..18)
      if i % 2 == 0
        weather_for_that_day = result["forecast"]["txt_forecast"]["forecastday"][i]["fcttext"]
        puts "The weather for day #{j} is #{weather_for_that_day}"
        j += 1
      end
    end
    puts
  end
end

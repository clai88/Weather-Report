require 'httparty'
require 'pry'
class WeatherClient
  include HTTParty
  base_uri 'api.wunderground.com/api/6fb454176eef8ba8'
  def initialize(zip_code)
    @zip_code = zip_code
  end
  #http://api.wunderground.com/api/6fb454176eef8ba8/geolookup/q/20854.json
  def get_zip_code_weather
    self.class.get("/forecast/q/#{@zip_code}.json")
  end

  def return_current_weather
    result = get_zip_code_weather

    curr_weather = result["forecast"]["txt_forecast"]["forecastday"][0]["fcttext"]
    puts "The weather is currently #{curr_weather}"
  end
end

#c = WeatherClientWeather.new(20854)
#binding.pry

require 'httparty'
require 'pry'
class WeatherClientMoon
  include HTTParty
  base_uri 'api.wunderground.com/api/6fb454176eef8ba8'
  def initialize(state,city)
    @city = city
    @state = state
  end
  #http://api.wunderground.com/api/6fb454176eef8ba8/astronomy/q/MD/Potomac.json
  def get_zip_code_weather
    self.class.get("/astronomy/q/#{@state}/#{@city}.json")

  end

  def return_sunrise_sunset
    result = get_zip_code_weather
    sunrise_hour = result["moon_phase"]["sunrise"]["hour"]
    sunrise_min = result["moon_phase"]["sunrise"]["minute"]
    sunset_hour = result["moon_phase"]["sunset"]["hour"]
    sunset_min = result["moon_phase"]["sunset"]["minute"]

    puts "Sunrise is at #{sunrise_hour}:#{sunrise_min}.  Sunset is at #{sunset_hour}:#{sunset_min}."


  end
end

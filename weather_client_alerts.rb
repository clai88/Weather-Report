require 'httparty'
require 'pry'
class WeatherClientAlerts
  include HTTParty
  base_uri 'api.wunderground.com/api/6fb454176eef8ba8'
  def initialize(state,city)
    @city = city
    @state = state
  end
  #http://api.wunderground.com/api/6fb454176eef8ba8/alerts/q/MD/Potomac.json
  def get_zip_code_weather
    self.class.get("/alerts/q/#{@state}/#{@city}.json")
  end

  def return_alerts
    result = get_zip_code_weather
    alert_number = result["alerts"].size
    puts "There are currently #{alert_number} alerts in #{@city}, #{@state}."
  end


end

# binding.pry

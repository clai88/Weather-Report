require 'httparty'
require 'pry'
class WeatherClientLocation
  include HTTParty
  base_uri 'api.wunderground.com/api/6fb454176eef8ba8'
  def initialize(zip_code)
    @zip_code = zip_code
  end
  #http://api.wunderground.com/api/6fb454176eef8ba8/geolookup/q/20854.json
  def get_zip_code_weather
    self.class.get("/geolookup/q/#{@zip_code}.json")
  end

  def return_citystate
    result = get_zip_code_weather
    city = result["location"]["city"]
    state = result["location"]["state"]
    puts "You are currently in #{city}, #{state}."
    citystate = []
    citystate.push(city)
    citystate.push(state)
    citystate

  end
  #return value of city and state in array.

end

# binding.pry



#key = 6fb454176eef8ba8

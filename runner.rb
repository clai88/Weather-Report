require 'httparty'
require 'pry'
require "./weather_client"
require "./weather_client_location"
require "./weather_client_10_day.rb"
require "./weather_client_moon"
require "./weather_client_alerts"

class StartHere
  def user_input
    puts "Please enter a zip code"
    answer = gets.chomp.to_i
    self.print(answer)
  end

  def print(zip_code)
    location = WeatherClientLocation.new(zip_code)
    answer = location.return_citystate
    city = answer[0]
    state = answer[1]

    curr_weather = WeatherClient.new(zip_code)
    curr_weather.return_current_weather

    puts "warning. large block of text incoming. hit enter to continue"
    gets
    ten_day_forcast = WeatherClient10Day.new(state,city)
    ten_day_forcast.return_ten_day_weather

    astronomy = WeatherClientMoon.new(state,city)
    astronomy.return_sunrise_sunset

    alerts = WeatherClientAlerts.new(state,city)
    alerts.return_alerts
  end
end

hey = StartHere.new
hey.user_input

require './require.rb'

class ForecastTest < Minitest::Test

  def test_fetch_weather_location
    response = File.read("./weather_for_20854.json")

    stub_request(
    :get,
    "http://api.wunderground.com/api/6fb454176eef8ba8/geolookup/q/20854.json"
    ).to_return(body: response, headers: { content_type: "application/json"})

    w = WeatherClientLocation.new(20854)
    weather_as_hash = w.get_zip_code_weather
    assert_equal Hash, weather_as_hash.parsed_response.class

    assert_equal "Potomac",weather_as_hash["location"]["city"]
    assert_equal "MD",weather_as_hash["location"]["state"]
    # w.return_citystate
  end

  def test_fetch_weather_current
    w_response = File.read("./more_weather_20854.json")

    stub_request(
    :get,
    "http://api.wunderground.com/api/6fb454176eef8ba8/forecast/q/20854.json"
    ).to_return(body: w_response, headers: { content_type: "application/json"})


    w = WeatherClient.new(20854)
    weather_as_hash = w.get_zip_code_weather
    assert_equal Hash, weather_as_hash.parsed_response.class

    weather = "Isolated thunderstorms. Lows overnight in the low 70s."
    assert_equal weather,weather_as_hash["forecast"]["txt_forecast"]["forecastday"][0]["fcttext"]
    #w.return_current_weather
  end
  def test_ten_day_weather
    w_response = File.read("./10day.json")

    stub_request(
    :get,
    "http://api.wunderground.com/api/6fb454176eef8ba8/forecast10day/q/MD/Potomac.json"
    ).to_return(body: w_response, headers: { content_type: "application/json"})


    w = WeatherClient10Day.new("MD","Potomac")
    weather_as_hash = w.get_zip_code_weather
    assert_equal Hash, weather_as_hash.parsed_response.class

    expected_day = "Partly cloudy with a stray thunderstorm. Lows overnight in the low 70s.Partly cloudy early. Scattered thunderstorms developing in the afternoon. High 89F. Winds S at 5 to 10 mph. Chance of rain 60%.Sunny, along with a few afternoon clouds. A stray shower or thunderstorm is possible. High 96F. Winds SW at 5 to 10 mph.Intervals of clouds and sunshine. High 96F. Winds W at 5 to 10 mph."

    concat = ""
    for i in (0..6)
      if i%2 == 0
        concat += weather_as_hash["forecast"]["txt_forecast"]["forecastday"][i]["fcttext"]
      end
    end
    assert_equal expected_day,concat
    #w.return_ten_day_weather
  end

  def test_sunrise_sunset
    w_response = File.read("./weather_moon.json")
    stub_request(
    :get,
    "http://api.wunderground.com/api/6fb454176eef8ba8/astronomy/q/MD/Potomac.json"
    ).to_return(body: w_response, headers: { content_type: "application/json"})


    w = WeatherClientMoon.new("MD","Potomac")
    weather_as_hash = w.get_zip_code_weather

    assert_equal "20",weather_as_hash["moon_phase"]["sunset"]["hour"]
    assert_equal "53",weather_as_hash["moon_phase"]["sunrise"]["minute"]
    #w.return_sunrise_sunset
  end

  def test_alerts
    w_response = File.read("./weather_20854_alerts.json")

    stub_request(
    :get,
    "http://api.wunderground.com/api/6fb454176eef8ba8/alerts/q/MD/Potomac.json"
    ).to_return(body: w_response, headers: { content_type: "application/json"})


    w = WeatherClientAlerts.new("MD","Potomac")
    weather_as_hash = w.get_zip_code_weather

    assert_equal 0,weather_as_hash["alerts"].length
    w.return_alerts
    #w.return_sunrise_sunset
  end
end

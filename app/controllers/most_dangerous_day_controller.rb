class MostDangerousDayController < ApplicationController
  def index
    response = Faraday.get("https://api.nasa.gov/neo/rest/v1/feed?start_date=2018-01-01&end_date=2018-01-07&api_key=#{ENV['NASA_API_KEY']}")

    @asteroid_facade = AsteroidFacade.new(params)
  end
end

class AsteroidService
  attr_reader :start_date,
              :end_date

  def initialize(params)
    @start_date = params['start_date']
    @end_date = params['end_date']
  end

  def conn
    response = Faraday.get("https://api.nasa.gov/neo/rest/v1/feed?start_date=#{start_date}&end_date=#{end_date}&api_key=#{ENV['NASA_API_KEY']}")
    result = JSON.parse(response.body)
  end
end

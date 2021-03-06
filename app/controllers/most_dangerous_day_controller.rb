class MostDangerousDayController < ApplicationController
  def index
    asteroid_service = AsteroidService.new(params).conn
    @asteroid_facade = AsteroidFacade.new(params, asteroid_service).get_asteroid_days
  end
end

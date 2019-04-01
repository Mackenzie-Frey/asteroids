class MostDangerousDayController < ApplicationController
  def index
    @asteroid_facade = AsteroidFacade.new(params)
  end
end

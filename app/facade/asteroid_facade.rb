class AsteroidFacade
  attr_reader :start_date,
              :end_date

  def initialize(params)
    @start_date = params['start_date']
    @end_date = params['end_date']
  end

  
end

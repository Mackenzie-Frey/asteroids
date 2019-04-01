class AsteroidFacade
  attr_reader :start_date,
              :end_date

  def initialize(params, asteroid_service)
    @start_date = params['start_date']
    @end_date = params['end_date']
    @asteroid_service = asteroid_service
  end

  def asteroids
    binding.pry
    @asteroid_service
  end

  def most_dangerous_day
    count = 0
    number_of_days.times do
      @asteroid_service["near_earth_objects"][@start_date.to_date + count].to_s
      count += 1
    end
  end

  def number_of_days
    (@end_date.to_date - @start_date.to_date).to_i
  end
end

class AsteroidFacade
  attr_reader :start_date,
              :end_date

  def initialize(params, asteroid_service)
    @start_date = params['start_date']
    @end_date = params['end_date']
    @asteroid_service = asteroid_service["near_earth_objects"]
  end

  def most_dangerous_day(date_asteroids)
    date = (date_asteroids.max_by{|k,v| v}).first
    @asteroid_service[date]
  end

  def number_of_days
    (@end_date.to_date - @start_date.to_date).to_i + 1
  end

  def get_asteroid_days
    dangerous_asteroids_by_date = {}
    count = 0
    number_of_days.times do
      date = (@start_date.to_date + count).to_s
      dangerous_asteroids_by_date[date] = []
      @asteroid_service[date].each do |asteroid|
        if asteroid["is_potentially_hazardous_asteroid"]
          dangerous_asteroids_by_date[date] << asteroid
          binding.pry
        end
      end
      count += 1
    end
    most_dangerous_day(dangerous_asteroids_by_date)
  end
end

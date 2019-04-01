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
    date_asteroids = {}
    count = 0
    number_of_days.times do
      date = (@start_date.to_date + count).to_s
      asteroids_by_date = @asteroid_service[date]
      asteroids_by_date.each do |asteroid|
        # if asteroid["is_potentially_hazardous_asteroid"]
          binding.pry
          date_asteroids[date] = asteroids_by_date.count
        # end
      end
      count += 1
    end
    most_dangerous_day(date_asteroids)
  end
end

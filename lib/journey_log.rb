
class JourneyLog

  def initialize(journey_class: )
    @journey_class = journey_class
    @journeys = []
  end

  private
  def current_journey
    @current_journey ||= journey_class.new
  end

  def start

  end

  def finish

  end

  def journeys
    @journeys.dup
  end

end

require_relative "oystercard"
class Journey
  PENALTY_FARE = 6
  NORMAL_FARE = 1
  attr_reader :entry_station

  def initialize(entry_station:)
    @entry_station = entry_station
    @completed_journey = false
  end

  def complete?
    if @completed_journey == true
      return true
    else
      return false
    end
  end


  def fare
    if @completed_journey == true
      @completed_journey = false
      return NORMAL_FARE
    else
      return PENALTY_FARE
    end
  end

  def finish(station)
    @completed_journey = true
    self
  end


end

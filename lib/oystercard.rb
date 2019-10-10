class Oystercard

  attr_reader :balance
  attr_reader :entry_station
  attr_reader :exit_station
  attr_reader :journeys
  attr_reader :in_journey
  CARD_LIMIT = 90
  MINIMUM_CHARGE = 1

  def initialize
    @balance = 0
    @in_journey = false
    @journeys = {}

  end

  def top_up(money)
    fail 'over the limit' if @balance + money > CARD_LIMIT else @balance += money

  end

  def deduct(money)
    @balance -= money
  end

  def touch_in(entryStation)
    fail 'not enough' if @balance < MINIMUM_CHARGE
    fail 'failed to touch out' if @in_journey == true
    @journeys[:entry_station] = entryStation
    @in_journey = true
    @entry_station = entryStation
  end

  def touch_out(exitStation)
    fail 'failed to touch in' if @in_journey == false
    deduct(MINIMUM_CHARGE)
    @journeys[:exit_station] = exitStation
    @in_journey = false
    @entry_station = nil
    @exit_station = exitStation
  end

end

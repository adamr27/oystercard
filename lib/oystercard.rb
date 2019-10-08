class Oystercard

  attr_reader :balance
  attr_reader :entry_station
  attr_reader :exit_station
  attr_reader :journeys
  CARD_LIMIT, MINIMUM_CHARGE =90, 1

  def initialize
    @balance, @in_journey, @journeys = 0, false, {}

  end

  def top_up(money)
    fail 'over the limit' if @balance + money > CARD_LIMIT else @balance += money

  end

  def deduct(money)
    @balance -= money
  end

  def in_journey?
    @in_journey
  end

  def touch_in(entryStation)
    fail 'not enough' if @balance < MINIMUM_CHARGE
    @journeys[:entry_station] = entryStation
    @in_journey, @entry_station = true, entryStation
  end

  def touch_out(exitStation)
    deduct(MINIMUM_CHARGE)
    @journeys[:exit_station] = exitStation
    @in_journey, @entry_station, @exit_station = false, nil, exitStation
  end

end

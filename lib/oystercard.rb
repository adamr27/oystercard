class Oystercard

  attr_reader :balance
  attr_reader :entry_station
  CARD_LIMIT, MINIMUM_CHARGE =90, 1


  def initialize
    @balance, @in_journey = 0, false

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

  def touch_in(station)
    fail 'not enough' if @balance < MINIMUM_CHARGE
    @entry_station = station
    @in_journey = true
  end

  def touch_out
    deduct(MINIMUM_CHARGE)
    @in_journey, @entry_station = false, nil

  end

end

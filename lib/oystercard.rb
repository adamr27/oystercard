class Oystercard

  attr_reader :balance
  CARD_LIMIT=90

  def initialize
    @balance, @travelling = 0, false

  end

  def top_up(money)
    fail 'over the limit' if @balance + money > CARD_LIMIT else @balance += money
  end

  def deduct(money)
    @balance -= money
  end

  def in_journey?
    @travelling
  end

  def touch_in
    @travelling = true
  end

  def touch_out
    @travelling = false
  end
end

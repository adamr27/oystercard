class Oystercard

  attr_reader :balance
  CARD_LIMIT=90

  def initialize
    @balance = 0
  end

  def top_up(money)
    fail 'over the limit' if @balance + money > CARD_LIMIT else @balance += money
  end

end

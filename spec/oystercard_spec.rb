require 'oystercard'
describe Oystercard do

  it 'has a balance of 0 when started' do
    expect(subject.balance).to eq(0)
  end

  it 'can add money to my card' do
    expect(subject.top_up(10.10)).to eq(subject.balance)
  end

  it 'cannot add more than 90' do
    expect{ subject.top_up(100) }.to raise_error('over the limit')
  end

  it 'cannot add more to maxed balance' do
    max_balance = Oystercard::CARD_LIMIT
    subject.top_up(max_balance)
    expect{subject.top_up(1)}.to raise_error('over the limit')
  end

  it "can take money off the card" do
    subject.top_up(20)
    expect(subject.deduct(10)).to eq(10)
  end

  it "can check if in journey?" do
    expect(subject.in_journey?).to eq(false)
  end

  it "can be touched in" do
    subject.top_up(20)
    subject.touch_in
    expect(subject.in_journey?).to eq(true)
  end

  it "can touch back out" do
    subject.top_up(20)
    subject.touch_in
    subject.touch_out
    expect(subject.in_journey?).to eq(false)
  end

  it 'cannot deduct if balance is less than 1' do
    expect{ subject.touch_in }.to raise_error 'not enough'
  end

  it 'money comes out when touch out' do
    subject.top_up(20)
    subject.touch_in
    expect { subject.touch_out }.to change{subject.balance}.by(-1)
  end
end

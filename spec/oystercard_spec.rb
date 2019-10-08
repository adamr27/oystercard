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
    subject.touch_in("station1")
    expect(subject.in_journey?).to eq(true)
  end

  it "can touch back out" do
    subject.top_up(20)
    subject.touch_in("station1")
    subject.touch_out("station1")
    expect(subject.in_journey?).to eq(false)
  end

  it 'cannot deduct if balance is less than 1' do
    expect{ subject.touch_in("station1") }.to raise_error 'not enough'
  end

  it 'money comes out when touch out' do
    subject.top_up(20)
    subject.touch_in("station1")
    expect { subject.touch_out("station1") }.to change{subject.balance}.by(-1)
  end

  let (:station){double :station}
  it 'stores the entry station' do
    subject.top_up(20)
    subject.touch_in(station)
    expect(subject.entry_station).to eq station
  end
  let (:station){double :station}
  it "will forget the entry station on touch out" do
    subject.top_up(20)
    subject.touch_in(station)
    subject.touch_out("station1")
    expect(subject.entry_station).to eq(nil)
  end
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }

  it 'stores exit stations' do
    subject.top_up(20)
    subject.touch_in(entry_station)
    subject.touch_out(exit_station)
    expect(subject.exit_station).to eq exit_station
  end
  it 'has an empty list of journys by default' do
    expect(subject.journeys).to be_empty
  end
  let(:journey){ {entry_station: entry_station, exit_station: exit_station} }
  it 'stores a journey' do
    subject.top_up(20)
    subject.touch_in(entry_station)
    subject.touch_out(exit_station)
    expect(subject.journeys).to include journey
  end
  let(:journey){ {entry_station: entry_station, exit_station: exit_station} }
  it 'failing to touch in' do
    subject.top_up(20)
    expect{subject.touch_out(exit_station)}.to raise_error 'failed to touch in'
  end
  let(:journey){ {entry_station: entry_station, exit_station: exit_station} }
  it 'fail to touch out' do
    subject.top_up(20)
    subject.touch_in(entry_station)
    expect{subject.touch_in(entry_station)}.to raise_error 'failed to touch out'
  end
end

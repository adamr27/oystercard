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
end

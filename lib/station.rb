class Station
  attr_reader :name
  attr_reader :zone

  def initialize(name: name, zone: zone)
    @name = name
    @zone = zone
  end

end

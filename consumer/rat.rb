class Rat
  attr_reader :name
  attr_accessor :age
  attr_accessor :weight

  def initialize name
    @name = name
  end

  def == other
    other.is_a?(Rat) && other.name == name
  end
end
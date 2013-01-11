class Item < GameObject

  attr_accessor :name, :points, :symbol, :pickable, :decision

  def initialize
    super
    @name =""
    @points = 0
  end

  def self.create_item(type)
    result = Item.new

    case type
    when :diamond
      result.name = "Diamond"
      result.points = 50
      result.symbol = "* "
      result.pickable = true
      result.decision = false
    when :emerald
      result.name = "Emerald"
      result.points = 20
      result.symbol = "+ "
      result.pickable = true
      result.decision = false
    when :coin
      result.name = "Coin"
      result.points = 5 
      result.symbol = "c " 
      result.pickable = true
      result.decision = false
    when :wall
      result.name = "Wall"
      result.points = 0
      result.pickable = false  
      result.symbol = "# "
      result.decision = false
    when :dec
      result.name = "Dec"
      result.points = 0
      result.pickable = true  
      result.symbol = ". "
      result.decision = true    
    else
      raise "unknown item type"
    end

    return result
  end

  def as_symbol
    self.symbol
  end
end  


class GameObject

  attr_accessor :position, :gamefield

  def initialize
    @position = [0, 0] 
  end

  def place(x, y)
    self.position[0] = x
    self.position[1] = y
  end


  def move(x, y)
   self.position[0] += x
   self.position[1] += y
  end  

  def x
    self.position[0]
  end

  def y
    self.position[1]
  end

  def x=(x)
    self.position[0] = x
  end

  def y=(y)
    self.position[1] = y
  end

  def as_symbol
    "? "
  end

  def think
  end
end  
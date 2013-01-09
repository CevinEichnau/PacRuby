class Enemy < GameObject

  attr_accessor :speed, :name, :gamefield, :items


  def initialize
    super
    @speed = 0
    @name = "Enemy"
    @items = []
  end


 def think
  
  #n =  self.gamefield.nearest_decision(self)
  #puts "=>#{n}<="
  #if self.x < n.first 
  #  self.move_r
  #elsif self.x > n.first
  #  self.move_l
  #elsif self.y < n.last
  #  self.move_d
  #elsif self.y > n.last
  #  self.move_u
  #else
  # do nothing      
  #end  
      
 end 

  def move_u
    if self.y > 1
      self.gamefield.move_object(0, -1, self) do |old|
        gamefield.check_movement(self, old)
      end
    end
    self.drop_items
  end
  
  def move_d
    if self.y < self.gamefield.size 
      self.gamefield.move_object(0, 1, self) do |old|
        gamefield.check_movement(self, old)
      end
    end
    self.drop_items
  end

  def move_r
    if self.x < self.gamefield.size
      self.gamefield.move_object(1, 0, self) do |old|
      gamefield.check_movement(self, old)
      end
    end
    self.drop_items
  end

  def move_l 
    if self.x > 1 
      self.gamefield.move_object(-1, 0, self) do |old|
        gamefield.check_movement(self, old)
      end
    end
    self.drop_items
  end

  def as_symbol
    "E "
  end  

  def remember_item(item)
    self.items << item
  end

  def drop_items
    self.items.each do |item| 
      if self.position != item.position 
        self.gamefield.set_at(item.x, item.y, item)
      end
    end 
  end

end  
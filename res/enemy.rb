class Enemy < GameObject

  attr_accessor :speed, :name, :gamefield, :items


  def initialize
    super
    @speed = 0
    @name = "Enemy"
    @items = []
  end


 def think
  n = Node.new(self.x, self.y)
  n.evaluate_step(self.gamefield, 5)
  self.gamefield.evaluateNode(self.x, self.y, self.gamefield.player.x, self.gamefield.player.y)
  puts "x:#{self.x} y:#{self.y}"
  puts "x:#{n.node.x} y:#{n.node.y}"

  if self.y != n.node.y
    if self.y < n.node.y
      self.move_d
    else
      self.move_u
    end  
  elsif self.x != n.node.x
    if self.x < n.node.x
      self.move_r
    else
      self.move_l
    end 
  end  
 end 


 
  def move_u
    if self.y > 0
      self.gamefield.move_object(0, -1, self) do |old|
        gamefield.check_movement(self, old)
      end
    end
    self.drop_items
  end
  
  def move_d
    if self.y < self.gamefield.size-1 
      self.gamefield.move_object(0, 1, self) do |old|
        gamefield.check_movement(self, old)
      end
    end
    self.drop_items
  end

  def move_r
    if self.x < self.gamefield.size-1
      self.gamefield.move_object(1, 0, self) do |old|
      gamefield.check_movement(self, old)
      end
    end
    self.drop_items
  end

  def move_l 
    if self.x > 0
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
    to_remove = []
    self.items.each do |item| 
      if self.position != item.position
        self.gamefield.set_at(item.x, item.y, item)
        to_remove << item
      end
    end 
    self.items -= to_remove
  end

    def items_position
    to_pos = []
    self.items.each do |item| 
      if self.position == item.position
        to_pos << item.position
      end
    end 
     to_pos
  end

end  
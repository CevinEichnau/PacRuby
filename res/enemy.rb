class Enemy < GameObject

  attr_accessor :speed, :name, :gamefield, :items


  def initialize
    super
    @speed = 0
    @name = "Enemy"
    @items = []
  end


 def think
  var = ""
     if self.gamefield.field.length == 400
     
      n =  self.gamefield.nearest_decision(self)
       t = self.items_position.first
      puts "=>#{t}<==>#{self.position}<="
     

      #puts "=>#{n}<="

      if self.position == t
        self.chace_player
      else  
        if self.x < n.first 
          #self.move_r
          self.chace_player
          var =  "r"
        elsif self.x > n.first
          #self.move_l
          self.chace_player
          var =  "l"
        elsif self.y < n.last
          #self.move_d
          self.chace_player
          var = "d"
        elsif self.y > n.last
          #self.move_u
          self.chace_player
          var = "u"
        else
        # do nothing      
        end 
      end 
      # do nothing
   end 
   return var 
 end 


 def chace_player
  
  if self.x == self.gamefield.player.x
    if self.y > self.gamefield.player.y
      self.move_u
    elsif self.y < self.gamefield.player.y
      self.move_d
    elsif
      wall = nil
      self.gamefield.field.each do |obj|
        if obj.pickable
          if obj.y == self.gamefield.player.y
            if self.x > self.gamefield.player.x
              self.move_l
            elsif self.x < self.gamefield.player.x
              self.move_r
            end  
          end  
        end  
      end  
     # if  

      #else 
      
      #end  
    else
      raise "nothing smaller or bigger then x"  
    end

  elsif self.y == self.gamefield.player.y
    if self.x > self.gamefield.player.x 
      self.move_l
    elsif self.x < self.gamefield.player.x
      self.move_r
    else
      raise "nothing smaller or bigger then y"  
    end

  else
    if self.x > self.gamefield.player.x
      self.move_l
    elsif self.x < self.gamefield.player.x
      self.move_r
    else
      if self.y > self.gamefield.player.y
        self.move_u
      elsif self.y < self.gamefield.player.y
        self.move_d
      else
        raise "Iam stupid! no way"
      end 
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
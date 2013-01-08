class Player < GameObject

  attr_accessor :name, :live, :items, :points, :dec

  def initialize
    super
    @name = ""
    @live = 5
    @items = []
    @points = 0
    @dec = []
  end

  def player_name(name)
    self.name = name
  end

  def stats
     "Name: "+self.name+"\t Items: "+self.items.to_s+"\t Lives: "+self.live.to_s+"\t Points: "+self.points.to_s
  end 

  def as_symbol
    "P "
  end


  def remember_item(item)
    self.dec << item
  end

  def drop_items
    self.dec.each do |item| 
      if self.position != item.position 
        self.gamefield.set_at(item.x, item.y, item)
      end
    end 
  end


end  




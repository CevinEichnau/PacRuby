class Gamefield

  attr_accessor :size, :field, :player, :item

  def initialize

    @size = 20
    @field = []
    @item = [1,2]
  end


  def size=(value)
    @size = value

    a_size = value * value
    self.field.clear
    while self.field.length < a_size.to_i
      self.field << nil 
    end
  end

  def evaluateNode(x, y, x1, y1)
    px = self.player.x
    py = self.player.y
    dx = x - px
    dy = y - py
    wert = 0
    a1 = Math.sqrt(dx * dx + dy * dy)

    dx = x1 - px
    dy = y1 - py
    a2 = Math.sqrt(dx * dx + dy * dy)


    if a1 > a2 
      wert = 10
    elsif a1 < a2
      wert = 9
    end
    return wert     
  end  


  def to_string
    string = "#"*self.size*2 + "##"
    string << "\n"
    
    y = 0
    while y < self.size do 
      
      x = 0
      string << "#"
      while x < self.size do 
       
        if f = get_at(x, y)
          string << f.as_symbol
        else
          string << "  "
        end
         x += 1
      end
      y += 1
      string << "#\n"
    end  
    string << "#"*self.size*2 + "##"
   string
  end  

  # Holt ein Objekt an Position x y
  def get_at(x, y)
    pos = get_address(x, y)
    self.field[pos]
  end

  # Setzt das Objekt an Position x y. Verändert auch die Position am Objekt selbst
  def set_at(x, y, game_object)
    raise "Feld ist bereits besetzt:obj:#{game_object} x:#{x} y:#{y}" if get_at(x, y)
    pos = get_address(x, y)
    self.field[pos] = game_object
    self.field[pos] 
    game_object.place(x, y) if !game_object.nil?
    
  end

  def get_address(x, y)
    if x >= 0 && x < self.size && y >= 0 && y < self.size 
      return x + self.size * y    
    else  
      raise "Wrong coordinates! x:#{x} y:#{y}"  
    end
  end

  def move_object(x, y, obj)
     
    # ist das Objekt im Spielfeld?
    raise "Objekt nicht im Spielfeld: #{obj} x:#{x} y:#{y}  real position: x: #{obj.x} y: #{obj.y}" if get_at(obj.x, obj.y) != obj
    # berechne die neuen Zielkoordinaten

    x += obj.x
    y += obj.y
    
    if old_obj = get_at(x, y)
      continue = yield(old_obj) if block_given?
      if !continue
        return
      end

    end

    raise "Feld ist besetzt" if get_at(x, y)
    pos = get_address(obj.x, obj.y)
    self.field[pos] = nil
    set_at(x, y, obj)
   
   
    
    
    

  end

  def check_movement(obj, old_obj)
    if obj.is_a? Enemy
      if old_obj.is_a? Player
        old_obj.live -= 1
      elsif old_obj.is_a? Item
          if !old_obj.pickable
            return false
          end
        obj.remember_item(old_obj)
        remove_at(old_obj.x, old_obj.y)
        return true
      end
    elsif obj.is_a? Player
      if old_obj.is_a? Item
          if !old_obj.pickable
            return false
          end
          if old_obj.decision == true
            obj.remember_item(old_obj)
            remove_at(old_obj.x, old_obj.y)
            return true
          end
        obj.points += old_obj.points
        obj.items << old_obj.name
        remove_at(old_obj.x, old_obj.y)
        return true
      end
    else
      # do nothing
    end
    return false
  end

  def remove_at(x, y)
    pos = get_address(x, y)
    obj = self.field[pos]
    self.field[pos] = nil
    return obj
  end  

  def win?(player)
    if player.live == 0
      return false
    end
    return true  
  end


  def read_file(path="./res/field.txt")
    map = ""
    x=0
    y=0
    self.size= 20
    File.open(path, "r") do |file|
      file.each_line do |line|
        line=line.gsub(/\\n/, "")
        
        x = 0
        line.each_char do |c|
          

          
          if c == "#"
          w=Item.create_item(:wall)
          w.x = x
          w.y = y
          set_at(w.x, w.y, w)
          elsif c == "X" 
          d=Item.create_item(:dec)
          self.item = d
          d.x = x
          d.y = y
          set_at(d.x, d.y, d)
          end
          x += 1
        end  
        y += 1
      end  

    end  
   
  end  

 def think
   to_update = self.field.select do |obj|
      obj.is_a? GameObject
   end
   to_update.each do |obj|
      obj.think
   end 
 end




  def nearest_decision(enemy)
    dec = self.field.select do |d|
      d.is_a?(Item) && d.decision
    end

    return nil if dec.empty?

    mapped = dec.map do |d|
      [d, (d.x - enemy.x).abs + (d.y - enemy.y).abs]
    end

    mapped.sort! do |o, p|
      o[1] <=> p[1]
    end

    item = mapped.first[0]
    item.position
  end
  


  def create_enemy(x, y)
    e = Enemy.new
    e.gamefield = self
    set_at(x, y, e)
    return e
  end

  def create_player(x, y)
    e = Player.new
    e.gamefield = self
    self.player = e
    set_at(x, y, e)
    return e
  end

  def create_item(x, y, type)
    e = Item.create_item(type)
    e.gamefield = self
    set_at(x, y, e)
    return e
  end
end  






































                                                                                          ##########################################
                                                                                          #                  #                     #
                                                                                          #  #####  #######  #  ######  #########  #
                                                                                          #  #####  #######  #  ######  #########  #
                                                                                          #  #####                      #########  #
                                                                                          #          #  #########  ###             #
                                                                                          #  #####   #   #######   # ######  ####  #
                                                                                          #  #####  ####         ### ######  ####  #
                                                                                          #          #    #  #    ##               #
                                                                                          #######  ###  ###  ###  ##  ########  ####
                                                                                          ######        #      #                   #
                                                                                          ######  ####  ########  ######  ####  ####
                                                                                          ######  ####              ####  ####  ####
                                                                                          ######  ####  ##########  ####  ####  ####
                                                                                          #                 ##                     #
                                                                                          #  ######  #####  ##  ######  #########  #
                                                                                          #     ###                     ###        #
                                                                                          ####  ###  ##  #########  ##  ###  #######
                                                                                          #     ###  ##  #########  ##  ###  #######
                                                                                          #          ##     ##      ##             #
                                                                                          #  #############  ##  #################  #
                                                                                          #                                        #
                                                                                          ##########################################

                                                                                          ##########################################
                                                                                          #                  #                     #
                                                                                          #  #####  #######  #  ######  #########  #
                                                                                          #  #####  #######  #  ######  #########  #
                                                                                          #  #####                      #########  #
                                                                                          #          #  #########  ###             #
                                                                                          #  #####   #   #######   # ######  ####  #
                                                                                          #  #####  ####         ### ######  ####  #
                                                                                          #          #    #  #    ##               #
                                                                                          #######  ###  ###  ###  ##  ########  ####
                                                                                          ######        #      #                   #
                                                                                          ######  ####  ########  ######  ####  ####
                                                                                          ######  ####              ####  ####  ####
                                                                                          ######  ####  ##########  ####  ####  ####
                                                                                          #                 ##                     #
                                                                                          #  ######  #####  ##  ##### E #########  #
                                                                                          #     ###                .... ###        #
                                                                                          ####  ###  ##  ######### .##  ###   ######
                                                                                          #     ###  ##  ######### .##  ### E ######
                                                                                          #          ##     ## .....##     ........#
                                                                                          #  #############  ## .################# .#
                                                                                          #                    ........> P <.......#
                                                                                          ##########################################




















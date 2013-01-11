require "spec_helper.rb"


describe Gamefield do

describe "#evaluateNode()" do 
  before :each do 
    @f = Gamefield.new
    @f.size = 4
    @p = @f.create_player(3, 0)
  end

  it "should return an integer" do
    value = @f.evaluateNode(1, 2, 0, 2)
    assert(value.is_a?(Fixnum), "Its dosnt return an interger ")
  end

  it "should return a right integer" do
    value = @f.evaluateNode(1, 2, 0, 2)
    assert(value == 9, "Its dosnt return a right interger ")
  end



end  

  describe "#size=" do
    it "should resize the field" do
      field = Gamefield.new
      field.size= 20
      field.field.length.should == 20 * 20

      field.size= 30
      field.field.length.should == 30 * 30
    end
  end


  describe "#remove_at" do 
    before :each do 
      @field = Gamefield.new
      @field.size= 20 
      @total_size = 20 * 20 
      @coin = Item.create_item(:coin)
      @field.set_at(2, 3, @coin) 
    end  

    it "should remove the item from field" do
      @field.remove_at(2, 3)
      assert(@field.get_at(2, 3) == nil, "Object not removed" ) 
    end

    it "should return the removed item" do
      obj = @field.remove_at(2, 3)
      assert(obj == @coin, "Ist nicht unser object!")
    end

    it "should not change the field size" do
      @field.remove_at(2, 3)
      assert_equal(@field.field.length, @total_size, "Ist nicht mehr Gross genug!")
    end

  end  

  describe "#set_at" do
    before :each do
      @field = Gamefield.new
      @field.size= 20
      @total_size = 20 * 20
    end

    it "should be placed in the Gamefield " do
      item = Item.create_item(:diamond)
      @field.set_at(2, 3, item)
      assert(@field.get_at(2, 3) == item, "Ist kein GamObject" )
    end  

    it "should raise an error if same coordinate is used twice" do
      item1 = Item.create_item(:diamond)
      item2 = Item.create_item(:diamond)
      assert_raise RuntimeError do
        @field.set_at(2, 3, item1)
        @field.set_at(2, 3, item2)
      end
    end 

    it "should not increase the field length" do
      item = Item.create_item(:diamond)
      @field.set_at(2, 3, item)
      assert(@field.field.length == @total_size)
    end

    it "should raise an error for invalid coordinates" do
      item = Item.create_item(:diamond)
      assert_raise RuntimeError do
        @field.set_at(1000, 10000, item)
      end
    end

    it "should raise an error for invalid coordinates" do
      item = Item.create_item(:diamond)
      assert_raise RuntimeError do
        @field.set_at(-1, -10, item)
      end
    end
  end

  describe "#move_object" do
    before :each do
      @field = Gamefield.new
      @field.size= 20
      @total_size = 20 * 20
      @item = @field.create_enemy(1, 1)
    end

    it "should move about the given coordinates" do
      @field.move_object(2, 5, @item)
      @item.x.should == 3
      @item.y.should == 6
    end

    it "should not duplicate objects after move" do
      counter = 0 
      @field.move_object(1, 0, @item)
      
      @field.field.each do |obj|
        if obj.is_a? Enemy
          counter += 1
        end 
      end 
      
      assert(counter == 1, "Object duplicated !")  
    end  
  end

  describe "#to_string" do
    before :each do
      @field = Gamefield.new
      @field.size= 20
      @total_size = 20 * 20

      @field.create_enemy(1, 1)
      @field.create_player(1, 2)
      @field.create_item(2, 0, :wall)
      @field.create_item(2, 1, :wall)
      @field.create_item(2, 2, :wall)
    end

    it "should print enemies" do
      @field.to_string.include?("E ")
    end

    it "should print the player" do
      @field.to_string.include?("P ")
    end

    it "should print walls" do
      @field.to_string.include?("# ")
    end
  end

  describe "#think" do 
    before :each do
      @field = Gamefield.new
      @field.size= 20

      @objects = []
      @objects << @field.create_enemy(1, 1)
      @objects << @field.create_enemy(1, 2)
      @objects << @field.create_enemy(1, 3)
      @objects << @field.create_enemy(1, 4)
    end

    it "should call #think on each game object once" do
      
      @objects.each do |obj|
       obj.should_receive(:think).once
      end
      @field.think
    end
  end

  describe "#read_file" do 
    it "should be placed all object from file" do 
      field = Gamefield.new
      field.read_file "./res/field.txt"

      enemies = 0
      items = {}

      field.field.each do |entry|
        if entry.is_a?(Enemy)
          enemies += 1
        elsif entry.is_a?(Item)
          items[entry.name] = 0
          e = items[entry.name]

           
          items[entry.name] += 1
        end
      end




          
            field = Gamefield.new
            field.size= 20
            @gamefield = field
            counter = 0
            item = 0
            dec = 0
          map = ""
          x=0
          y=0
          File.open("./res/field.txt", "r") do |file|
            file.each_line do |line|
              
              x = 0
              line.each_char do |c|
                
                counter += 1
                
                dec 
                
                
                if c == "#"
                w=Item.create_item(:wall)
                w.x = x
                w.y = y
                @gamefield.set_at(w.x, w.y, w)
                item += 1
                elsif c == "X" 
                d=Item.create_item(:dec)
                @gamefield.item = d
                d.x = x
                d.y = y
                @gamefield.set_at(d.x, d.y, d)
                dec += 1
                end
                x += 1
              end  
              y += 1
            end  

          end  
          assert(counter == 420, "Nicht alle 400 Eintraege vorhanden")
          assert(item == 225, "Nicht alle 225 items  vorhanden")
          assert(dec == 25, "Nicht alle 25 dec vorhanden")
        
    end  
  end  



end
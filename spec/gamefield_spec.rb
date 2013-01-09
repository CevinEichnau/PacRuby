require "spec_helper.rb"


describe Gamefield do
  describe "#size=" do
    it "should resize the field" do
      field = Gamefield.new
      field.size= 20
      field.field.length.should == 20 * 20

      field.size= 30
      field.field.length.should == 30 * 30
    end
  end

  describe "#set_at()" do
    it "should be placed in the Gamefield " do
      field = Gamefield.new
      field.size= 20
      item = Item.create_item(:diamond)
      field.set_at(2, 3, item)
      assert(field.get_at(2, 3).is_a?(GameObject), "Ist kein GamObject" )
    end  
  end
  describe "#think" do 
    
    before :each do
      field = Gamefield.new
      field.size= 20

      item = Item.create_item(:diamond)
      field.set_at(2, 3, item)

      item1 = Item.create_item(:coin)
      field.set_at(2, 4, item1)

      field.create_enemy(4, 3)
      field.create_enemy(7, 3)

      field.think

      @field = field
    end

    it "should have 2 enemies in field" do
      counter = 0
      @field.field.each do |item|
        if item.is_a?(Enemy)
          counter += 1
        end
      end

      assert(2 == counter, "asdasd")
    end
  end

  describe "#read_file" do 
    it "should be placed all object from file" do 
          
          
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
              y += 1
              x = 0
              line.each_char do |c|
                x += 1
                counter += 1
                
                dec 
                @gamefield.get_at(x, y)
                
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

              end  

            end  

          end  
          assert(counter == 420, "Nicht alle 400 Eintraege vorhanden")
          assert(item == 225, "Nicht alle 225 items  vorhanden")
          assert(dec == 25, "Nicht alle 25 dec vorhanden")
        
    end  
  end  



end
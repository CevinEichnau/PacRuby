require "spec_helper.rb"

describe Enemy do 
  describe "#think" do

    #it "should move one times ?!" do 
    #  g=Gamefield.new
    #  e=Enemy.new
    #  e.gamefield = g
    #  g.size = 20
    #
    #  e.think
    #
    #  assert(e.x == e.x += 1, "He doesnt move only one times!")
    #end  






    it "should field length are 400 " do
      g=Gamefield.new
      e=Enemy.new
      e.gamefield = g
      g.size = 20

        a_size = g.size * g.size
        g.field.clear
        while g.field.length < a_size.to_i
          g.field << nil 
        end

        assert_equal( 400, g.field.length , "gamefield doesnt 400 length")


        player = Player.new
        e=Enemy.new
        e2=Enemy.new
        e.gamefield = g
        e2.gamefield = g
        g.player = player
        player.gamefield = g

         assert_equal( 400, g.field.length , "gamefield doesnt 400 length")

        i = Item.create_item(:coin)
        u = Item.create_item(:diamond)
        s = Item.create_item(:emerald)

        g.set_at(1, 0, player)
        assert_equal( 400, g.field.length , "gamefield doesnt 400 length")

        g.set_at(0, 13, e)
        assert_equal( 400, g.field.length , "gamefield doesnt 400 length")

        g.set_at(15, 0, e2)
        assert_equal( 400, g.field.length , "gamefield doesnt 400 length")

        g.set_at(0, 12, i)
        assert_equal( 400, g.field.length , "gamefield doesnt 400 length")

        g.set_at(2, 15, u)
        assert_equal( 400, g.field.length , "gamefield doesnt 400 length")

        g.set_at(18, 19, s)
        assert_equal( 400, g.field.length , "gamefield doesnt 400 length")

        map = ""
       # x=0
        y = 0
        File.open("./res/field.txt", "r") do |file|
          file.each_line do |line|
        
            x = 0
            line.each_char do |c|
              

              
              if c == "#"
              w=Item.create_item(:wall)
              w.x = x
              w.y = y
              g.set_at(w.x, w.y, w)
              elsif c == "X" 
              d=Item.create_item(:dec)
              g.item = d
              d.x = x
              d.y = y
              g.set_at(d.x, d.y, d)
              end
              x += 1
            end  
            y += 1
          end  
        end 
        i = e.y
        t = e.x  
        e.think
        puts "y:#{i}, #{e.y}"
        puts "x:#{t}, #{e.x}"
        if e.think == "d"
          assert(e.y == i += 1, "He doesnt move only one times! d ") 
        elsif e.think == "u"
          assert(e.y == i -= 1, "He doesnt move only one times! u ")
        elsif e.think == "l"
          assert(e.x == t -= 1, "He doesnt move only one times! l ") 
        elsif e.think == "r"
          assert(e.x == t += 1, "He doesnt move only one times! r ")
        else
          raise "nichts"  
        end  

        assert_equal( 400, e.gamefield.field.length , "enemy gamefield doesnt 400 length")
        assert_equal( 400, g.field.length , "gamefield doesnt 400 length")
        assert_equal( 400, player.gamefield.field.length , "player gamefield doesnt 400 length")
    end  
  end  
end  
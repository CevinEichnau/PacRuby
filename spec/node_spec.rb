require "spec_helper.rb"

describe Node do
  describe "#evaluate_step" do
    before :each do 
      @f = Gamefield.new
      @n = Node.new(1, 2)
      @f.size = 4
      @p = @f.create_player(3, 0)
    end  

    it "shoud return best node" do 

      @n.evaluate_step(@f, 5)

      assert_equal(2, @n.node.x, "x:#{@n.node.x} y:#{@n.node.y}")
    end  
  end  
end  
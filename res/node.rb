class Node
  attr_accessor :value, :x, :y, :nodes, :node

  def initialize(x, y)
    self.nodes = []
    self.x = x
    self.y = y
    self.value = 0
    self.node = nil
  end

  def evaluate_step(field, steps)
    raise "to high step value" if steps > 5
    return if steps == 0

    self.nodes << Node.new(self.x + 1, self.y)
    self.nodes << Node.new(self.x, self.y + 1)
    self.nodes << Node.new(self.x - 1, self.y)
    self.nodes << Node.new(self.x, self.y - 1)

    self.nodes.each do |n|
      n.value = field.evaluateNode(self.x, self.y, n.x, n.y)
      n.evaluate_step(field, steps-1) 
    end
     self.find_best_node
  end

  def find_max_path(current)
    max_value = current
    self.nodes.each do |node|
      v = node.find_max_path(current + self.value)
      max_value = v if v > max_value
    end  
    return max_value + self.value
  end

  def find_best_node
    max = 0
    node = nil
    self.nodes.each do |n|
      v = n.find_max_path(0)
      if v > max
        node = n
        max = v
      end
    end
    self.node = node
  end

end
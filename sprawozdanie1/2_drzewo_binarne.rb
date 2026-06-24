Node = Struct.new(:value, :left, :right)

class BST
  def initialize
    @root = nil
  end

  def insert(value)
    @root = insert_node(@root, value)
  end

  def search(value)
    search_node(@root, value)
  end

  def in_order
    collect_in_order(@root, [])
  end

  def pre_order
    collect_pre_order(@root, [])
  end

  def post_order
    collect_post_order(@root, [])
  end

  private

  def insert_node(node, value)
    return Node.new(value, nil, nil) if node.nil?
    if value < node.value
      node.left = insert_node(node.left, value)
    elsif value > node.value
      node.right = insert_node(node.right, value)
    end
    node
  end

  def search_node(node, value)
    return false if node.nil?
    return true  if node.value == value
    value < node.value ? search_node(node.left, value)
                       : search_node(node.right, value)
  end

  def collect_in_order(node, result)
    return result if node.nil?
    collect_in_order(node.left, result)
    result << node.value
    collect_in_order(node.right, result)
  end

  def collect_pre_order(node, result)
    return result if node.nil?
    result << node.value
    collect_pre_order(node.left, result)
    collect_pre_order(node.right, result)
  end

  def collect_post_order(node, result)
    return result if node.nil?
    collect_post_order(node.left, result)
    collect_post_order(node.right, result)
    result << node.value
  end
end

tree = BST.new
[5, 3, 7, 1, 4, 6, 8].each { |v| tree.insert(v) }

puts "In-order   (posortowane):       #{tree.in_order.join(' ')}"
puts "Pre-order  (korzen-lewy-prawy): #{tree.pre_order.join(' ')}"
puts "Post-order (lewy-prawy-korzen): #{tree.post_order.join(' ')}"
puts "Szukam 4: #{tree.search(4) ? 'znaleziono' : 'nie ma'}"
puts "Szukam 9: #{tree.search(9) ? 'znaleziono' : 'nie ma'}"


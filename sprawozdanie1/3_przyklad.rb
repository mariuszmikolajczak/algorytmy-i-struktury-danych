# Wzor Gaussa (shoelace formula) — pole poligonu na podstawie wspolrzednych
def area(points)
  n = points.length
  sum = 0.0
  n.times do |i|
    j = (i + 1) % n
    sum += points[i][:x] * points[j][:y]
    sum -= points[j][:x] * points[i][:y]
  end
  (sum / 2.0).abs
end

class Parcel
  attr_reader   :id, :surface_area, :boundary
  attr_accessor :left, :right

  def initialize(id, points)
    @id           = id
    @boundary     = points
    @surface_area = area(points)
    @left         = nil
    @right        = nil
  end
end

class ParcelIndex
  def initialize
    @root = nil
  end

  def insert(parcel)
    @root = insert_node(@root, parcel)
  end

  def find_by_area(lo, hi)
    results = []
    range_search(@root, lo, hi, results)
    results
  end

  private

  def insert_node(node, parcel)
    return parcel if node.nil?
    if parcel.surface_area < node.surface_area
      node.left  = insert_node(node.left,  parcel)
    else
      node.right = insert_node(node.right, parcel)
    end
    node
  end

  def range_search(node, lo, hi, results)
    return if node.nil?
    results << node if node.surface_area.between?(lo, hi)
    range_search(node.left,  lo, hi, results) if lo < node.surface_area
    range_search(node.right, lo, hi, results) if hi > node.surface_area
  end
end

index = ParcelIndex.new
index.insert(Parcel.new(1, [{x:0,y:0},{x:10,y:0},{x:10,y:10},{x:0,y:10}]))  # 100 m2
index.insert(Parcel.new(2, [{x:0,y:0},{x:5,y:0},{x:5,y:4},{x:0,y:4}]))      #  20 m2
index.insert(Parcel.new(3, [{x:0,y:0},{x:20,y:0},{x:20,y:15},{x:0,y:15}]))  # 300 m2
index.insert(Parcel.new(4, [{x:0,y:0},{x:8,y:0},{x:8,y:6},{x:0,y:6}]))      #  48 m2

puts "Dzialki o powierzchni 40-150 m2:"
index.find_by_area(40, 150).each do |p|
  puts "  ID=#{p.id}  powierzchnia=#{p.surface_area} m2"
end


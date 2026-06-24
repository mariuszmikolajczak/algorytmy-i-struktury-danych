# W Ruby nie deklarujemy typow - tablica moze przechowywac dowolne obiekty.
# Punkt reprezentujemy jako hash z kluczami :x i :y.

def distance(a, b)
  dx = b[:x] - a[:x]
  dy = b[:y] - a[:y]
  Math.sqrt(dx**2 + dy**2)
end

def perimeter(polygon)
  n = polygon.length
  # each_with_index + modulo - odpowiednik petli for z C++
  polygon.each_with_index.sum do |point, i|
    distance(point, polygon[(i + 1) % n])
  end
end

polygon = [
  { x: 0.0, y: 0.0 },
  { x: 4.0, y: 0.0 },
  { x: 4.0, y: 3.0 },
  { x: 0.0, y: 3.0 }
]

puts "Liczba wierzcholkow: #{polygon.length}"
polygon.each_with_index do |p, i|
  puts "  P#{i} = (#{p[:x]}, #{p[:y]})"
end
puts "Obwod poligonu: #{perimeter(polygon)}"


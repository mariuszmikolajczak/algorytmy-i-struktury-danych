INFINITY = Float::INFINITY
Edge = Struct.new(:from, :to, :weight)

def bellman_ford(edges, num_vertices, source)
  dist = Array.new(num_vertices, INFINITY)
  prev = Array.new(num_vertices, nil)
  dist[source] = 0

  (num_vertices - 1).times do
    edges.each do |edge|
      next if dist[edge.from] == INFINITY
      alt = dist[edge.from] + edge.weight
      if alt < dist[edge.to]
        dist[edge.to] = alt
        prev[edge.to] = edge.from
      end
    end
  end

  # V-ta iteracja: znajdz krawedz nadal relaksowalna I zaktualizuj prev,
  # zeby wskazywal w cykl
  cycle_node = nil
  edges.each do |edge|
    next if dist[edge.from] == INFINITY
    if dist[edge.from] + edge.weight < dist[edge.to]
      prev[edge.to] = edge.from
      cycle_node    = edge.to
      break
    end
  end

  [dist, prev, cycle_node]
end

STATIONS = { 0 => "Wroclaw", 1 => "Opole", 2 => "Katowice", 3 => "Czestochowa" }

edges = [
  Edge.new(0, 1,  20),
  Edge.new(1, 2,  15),
  Edge.new(2, 3, -50),
  Edge.new(3, 1,  10),
  Edge.new(0, 2,  80),
]

dist, prev, cycle_node = bellman_ford(edges, STATIONS.length, 0)

puts "Koszt podrozy z Wroclawia:"
dist.each_with_index do |d, i|
  puts "  do #{STATIONS[i]}: #{d == INFINITY ? 'nieosiagalny' : "#{d} zl"}"
end

if cycle_node
  # Cofnij sie V razy zeby na pewno wejsc w cykl
  node = cycle_node
  STATIONS.length.times { node = prev[node] }

  # Zbierz cykl
  cycle = []
  current = node
  loop do
    cycle << current
    current = prev[current]
    break if current == node
  end
  cycle << node
  cycle.reverse!

  names = cycle.map { |n| STATIONS[n] }
  total = cycle.each_cons(2).sum do |a, b|
    edges.find { |e| e.from == a && e.to == b }.weight
  end

  puts "\nBLAD W SYSTEMIE ROZLICZEN!"
  puts "Wykryto petle przesiadkowa generujaca strate:"
  puts "  #{names.join(' -> ')}"
  puts "  Laczny koszt petli: #{total} zl"
  puts "  Przewoznik traci #{total.abs} zl na kazdym okrazeniu tej petli."
else
  puts "\nSystem rozliczen poprawny — brak blednych petli dotacyjnych."
end

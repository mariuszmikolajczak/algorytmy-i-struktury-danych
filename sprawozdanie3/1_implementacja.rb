INFINITY = Float::INFINITY
Edge = Struct.new(:from, :to, :weight)

def bellman_ford(edges, num_vertices, source)
  dist = Array.new(num_vertices, INFINITY)
  prev = Array.new(num_vertices, nil)
  dist[source] = 0

  # Glowna petla: V-1 iteracji po wszystkich krawedziach
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

  # V-ta iteracja: wykrycie ujemnego cyklu
  cycle_node = nil
  edges.each do |edge|
    next if dist[edge.from] == INFINITY
    if dist[edge.from] + edge.weight < dist[edge.to]
      cycle_node = edge.to
      break
    end
  end

  [dist, prev, cycle_node]
end

def reconstruct_path(prev, source, target)
  path = []
  current = target
  while current
    path.unshift(current)
    break if current == source
    current = prev[current]
  end
  path.first == source ? path : []
end

# Graf z 5 wezlami, w tym krawedz z ujemna waga
edges = [
  Edge.new(0, 1,  6),
  Edge.new(0, 2,  7),
  Edge.new(1, 2,  8),
  Edge.new(1, 3, -4),
  Edge.new(1, 4,  5),
  Edge.new(2, 3,  9),
  Edge.new(2, 4, -3),
  Edge.new(3, 0,  2),
  Edge.new(3, 5,  7),
  Edge.new(4, 3,  7),
  Edge.new(4, 5,  2)
]

num_vertices = 6
source = 0
dist, prev, cycle_node = bellman_ford(edges, num_vertices, source)

if cycle_node
  puts "Wykryto ujemny cykl — wyniki moga byc niepoprawne."
else
  puts "Najkrotsze odleglosci od wezla #{source}:"
  dist.each_with_index do |d, i|
    puts "  do wezla #{i}: #{d == INFINITY ? 'nieosiagalny' : d}"
  end

  puts "\nSciezki od wezla #{source}:"
  (0...num_vertices).each do |target|
    path = reconstruct_path(prev, source, target)
    if path.empty?
      puts "  do #{target}: brak sciezki"
    else
      puts "  do #{target}: #{path.join(' -> ')}  (koszt: #{dist[target]})"
    end
  end
end


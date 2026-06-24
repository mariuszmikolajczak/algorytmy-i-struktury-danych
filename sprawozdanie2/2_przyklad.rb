INFINITY = Float::INFINITY

def dijkstra(graph, source)
  n    = graph.length
  dist = Array.new(n, INFINITY)
  prev = Array.new(n, nil)
  dist[source] = 0
  queue = [[0, source]]

  until queue.empty?
    current_dist, u = queue.min_by { |d, _| d }
    queue.delete([current_dist, u])
    next if current_dist > dist[u]

    graph[u].each do |v, weight|
      alt = dist[u] + weight
      if alt < dist[v]
        dist[v] = alt
        prev[v] = u
        queue << [alt, v]
      end
    end
  end

  [dist, prev]
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

# Miasta jako wezly grafu
CITIES = {
  0 => "Wroclaw",
  1 => "Opole",
  2 => "Czestochowa",
  3 => "Katowice",
  4 => "Krakow",
  5 => "Lodz"
}

# Siec drogowa — odleglosci w km (graf nieskierowany)
graph = Array.new(CITIES.length) { [] }

def add_road(graph, a, b, km)
  graph[a] << [b, km]
  graph[b] << [a, km]
end

add_road(graph, 0, 1, 87)   # Wroclaw  - Opole
add_road(graph, 1, 2, 119)  # Opole    - Czestochowa
add_road(graph, 1, 3, 93)   # Opole    - Katowice
add_road(graph, 2, 3, 74)   # Czestochowa - Katowice
add_road(graph, 2, 5, 119)  # Czestochowa - Lodz
add_road(graph, 3, 4, 75)   # Katowice - Krakow
add_road(graph, 4, 5, 252)  # Krakow   - Lodz

source = 0  # Wroclaw
dist, prev = dijkstra(graph, source)

puts "Najkrotsze trasy z #{CITIES[source]}:\n\n"
CITIES.each do |id, city|
  next if id == source
  path    = reconstruct_path(prev, source, id)
  city_path = path.map { |n| CITIES[n] }.join(" -> ")
  puts "  Do #{city}:"
  puts "    Trasa:     #{city_path}"
  puts "    Odleglosc: #{dist[id]} km\n\n"
end


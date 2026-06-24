INFINITY = Float::INFINITY

def dijkstra(graph, source)
  n    = graph.length
  dist = Array.new(n, INFINITY)  # najkrotsze odleglosci od zrodla
  prev = Array.new(n, nil)       # poprzednicy do odtworzenia sciezki
  dist[source] = 0

  # Kolejka priorytetowa: tablica par [odleglosc, wezel]
  queue = [[0, source]]

  until queue.empty?
    # Pobierz wezel o najmniejszej odleglosci
    current_dist, u = queue.min_by { |d, _| d }
    queue.delete([current_dist, u])

    # Jesli pobrany dystans jest przestarzaly — pomin
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

# Odtwarza sciezke od zrodla do celu korzystajac z tablicy poprzednikow
def reconstruct_path(prev, source, target)
  path = []
  current = target

  while current
    path.unshift(current)
    break if current == source
    current = prev[current]
  end

  # Jesli sciezka nie zaczyna sie od zrodla — nie istnieje
  path.first == source ? path : []
end

# ── Przyklad: graf z 6 wezlami ───────────────────────────────────────────────
# Reprezentacja: graph[u] = [[v, waga], ...]
graph = Array.new(6) { [] }

graph[0] << [1, 7]
graph[0] << [2, 9]
graph[0] << [5, 14]
graph[1] << [2, 10]
graph[1] << [3, 15]
graph[2] << [3, 11]
graph[2] << [5, 2]
graph[3] << [4, 6]
graph[4] << [5, 9]

source = 0
dist, prev = dijkstra(graph, source)

puts "Najkrotsze odleglosci od wezla #{source}:"
dist.each_with_index do |d, i|
  puts "  do wezla #{i}: #{d == INFINITY ? 'nieosiagalny' : d}"
end

puts "\nSciezki od wezla #{source}:"
(0...graph.length).each do |target|
  path = reconstruct_path(prev, source, target)
  if path.empty?
    puts "  do #{target}: brak sciezki"
  else
    puts "  do #{target}: #{path.join(' -> ')}  (koszt: #{dist[target]})"
  end
end


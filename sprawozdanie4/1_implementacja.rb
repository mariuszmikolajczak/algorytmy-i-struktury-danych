# Wersja podstawowa
def bubble_sort(array)
  arr = array.dup  # nie modyfikujemy oryginalu
  n = arr.length

  (n - 1).times do |i|
    # Po i przejsciach ostatnie i elementow jest juz na miejscu
    (0...(n - 1 - i)).each do |j|
      if arr[j] > arr[j + 1]
        arr[j], arr[j + 1] = arr[j + 1], arr[j]  # zamiana miejscami
      end
    end
  end

  arr
end

# Wersja zoptymalizowana — przerywa gdy tablica jest juz posortowana
def bubble_sort_optimized(array)
  arr = array.dup
  n = arr.length

  loop do
    swapped = false

    (0...(n - 1)).each do |j|
      if arr[j] > arr[j + 1]
        arr[j], arr[j + 1] = arr[j + 1], arr[j]
        swapped = true
      end
    end

    # Jesli nie bylo zadnej zamiany — tablica jest posortowana
    break unless swapped
  end

  arr
end

# Test
data = [5, 2, 9, 1, 7, 3]
puts "Tablica wejsciowa:  #{data.inspect}"
puts "Po sortowaniu:      #{bubble_sort(data).inspect}"
puts "Wersja optymalna:   #{bubble_sort_optimized(data).inspect}"

# Demonstracja stabilnosci i sortowania napisow
words = ["banan", "ananas", "czeresnia", "agrest"]
puts "\nNapisy wejsciowe:   #{words.inspect}"
puts "Posortowane:        #{bubble_sort(words).inspect}"

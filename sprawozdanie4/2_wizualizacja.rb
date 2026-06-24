def bubble_sort_verbose(array)
  arr = array.dup
  n = arr.length

  (n - 1).times do |i|
    (0...(n - 1 - i)).each do |j|
      if arr[j] > arr[j + 1]
        arr[j], arr[j + 1] = arr[j + 1], arr[j]
      end
    end
    puts "Po przejsciu #{i + 1}: #{arr.inspect}"
  end

  arr
end

puts "Sortowanie krok po kroku [5, 2, 9, 1, 7, 3]:"
bubble_sort_verbose([5, 2, 9, 1, 7, 3])

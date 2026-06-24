def quicksort_verbose(array, depth = 0)
  indent = "  " * depth
  return array if array.length <= 1

  pivot = array.first
  rest  = array[1..]
  mniejsze, wieksze = rest.partition { |x| x < pivot }

  puts "#{indent}pivot=#{pivot}  mniejsze=#{mniejsze.inspect}  wieksze=#{wieksze.inspect}"

  lewa  = quicksort_verbose(mniejsze, depth + 1)
  prawa = quicksort_verbose(wieksze,  depth + 1)
  lewa + [pivot] + prawa
end

puts "Przebieg sortowania [8, 3, 1, 7, 0, 10, 2]:"
wynik = quicksort_verbose([8, 3, 1, 7, 0, 10, 2])
puts "Wynik: #{wynik.inspect}"

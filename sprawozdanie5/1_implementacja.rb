# Wersja deklaratywna — czytelna, idiomatyczna dla Ruby
def quicksort(array)
  return array if array.length <= 1  # warunek bazowy

  pivot = array.first
  rest  = array[1..]

  # partition dzieli tablice na dwie wg warunku
  mniejsze, wieksze = rest.partition { |x| x < pivot }

  # Rekurencja + zlaczenie wynikow
  quicksort(mniejsze) + [pivot] + quicksort(wieksze)
end

# Wersja in-place (partycjonowanie Lomuto) — sortuje bez kopiowania tablic
def quicksort_inplace!(arr, low = 0, high = arr.length - 1)
  return arr if low >= high

  pivot_index = partition(arr, low, high)
  quicksort_inplace!(arr, low, pivot_index - 1)
  quicksort_inplace!(arr, pivot_index + 1, high)
  arr
end

def partition(arr, low, high)
  pivot = arr[high]   # pivot = ostatni element
  i = low - 1

  (low...high).each do |j|
    if arr[j] <= pivot
      i += 1
      arr[i], arr[j] = arr[j], arr[i]
    end
  end

  # Umiesc pivot na wlasciwej pozycji
  arr[i + 1], arr[high] = arr[high], arr[i + 1]
  i + 1
end

# Test
data = [8, 3, 1, 7, 0, 10, 2]
puts "Tablica wejsciowa:    #{data.inspect}"
puts "QuickSort (deklar.):  #{quicksort(data).inspect}"

data2 = [8, 3, 1, 7, 0, 10, 2]
quicksort_inplace!(data2)
puts "QuickSort (in-place): #{data2.inspect}"

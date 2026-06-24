Zawodnik = Struct.new(:nazwisko, :wynik_kg)

# Sortowanie balbelkowe malejaco po polu wynik_kg
def sortuj_zawodnikow(zawodnicy)
  arr = zawodnicy.dup
  n = arr.length

  loop do
    swapped = false

    (0...(n - 1)).each do |j|
      # Malejaco: zamieniamy gdy lewy ma MNIEJSZY wynik niz prawy
      if arr[j].wynik_kg < arr[j + 1].wynik_kg
        arr[j], arr[j + 1] = arr[j + 1], arr[j]
        swapped = true
      end
    end

    break unless swapped
  end

  arr
end

zawodnicy = [
  Zawodnik.new("Kowalski",  620),
  Zawodnik.new("Nowak",     710),
  Zawodnik.new("Wisniewski", 580),
  Zawodnik.new("Wojcik",    710),
  Zawodnik.new("Lewandowski", 655)
]

wyniki = sortuj_zawodnikow(zawodnicy)

puts "KLASYFIKACJA KONCOWA — trojbój silowy"
puts "-" * 38
wyniki.each_with_index do |z, i|
  puts format("%2d. %-14s %4d kg", i + 1, z.nazwisko, z.wynik_kg)
end

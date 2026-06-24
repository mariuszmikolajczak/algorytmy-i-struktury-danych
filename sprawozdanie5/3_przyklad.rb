Transakcja = Struct.new(:opis, :kwota, :data)

# QuickSort sortujacy malejaco po polu kwota
def sortuj_transakcje(transakcje)
  return transakcje if transakcje.length <= 1

  pivot = transakcje.first
  rest  = transakcje[1..]

  # Malejaco: "wieksze" to te o wyzszej kwocie niz pivot
  wieksze, mniejsze = rest.partition { |t| t.kwota > pivot.kwota }

  sortuj_transakcje(wieksze) + [pivot] + sortuj_transakcje(mniejsze)
end

transakcje = [
  Transakcja.new("Zakupy spozywcze",   -245.80, "2026-06-10"),
  Transakcja.new("Wyplata",            5200.00, "2026-06-01"),
  Transakcja.new("Rachunek za prad",   -180.50, "2026-06-15"),
  Transakcja.new("Przelew od klienta", 1500.00, "2026-06-08"),
  Transakcja.new("Subskrypcja",         -29.99, "2026-06-12"),
  Transakcja.new("Zwrot podatku",       820.00, "2026-06-20")
]

posortowane = sortuj_transakcje(transakcje)

puts "TRANSAKCJE — od najwyzszej do najnizszej kwoty"
puts "-" * 52
posortowane.each do |t|
  puts format("%-22s %10.2f zl   %s", t.opis, t.kwota, t.data)
end

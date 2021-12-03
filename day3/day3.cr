# part 1
def calc_stats(numbers) : Array(Tuple(String, String))
    columns = numbers.reduce{|m, a| m.zip(a).map {|(f, s)| "#{s}#{f}"} }.as(Array(String))
    columns.map do |a|
        histo = a.chars.tally
        histo.size == 1 ? {histo.first_key == '1' ? "0" : "1", histo.first_key.to_s} : histo.keys.minmax_by {|k| histo[k] }.map(&.to_s)
    end
end

lines = File.read("input").split("\n").map {|a| a.chars.map(&.to_s) }
epsilon, gamma = calc_stats(lines).reduce {|(f, s),(g, e)| {f + g, s + e} }.map {|x| x.to_i(2) }
puts gamma * epsilon

# part 2

oxygen = co2 = lines
(0...lines[0].size).each do |bitdex|
    if oxygen.size > 1
        least, most = calc_stats(oxygen)[bitdex]
        most = "1" if least == most
        oxygen = oxygen.select {|n| n[bitdex] == most }
    end

    if co2.size > 1
        least, most = calc_stats(co2)[bitdex]
        least = "0" if least == most
        co2 = co2.select {|n| n[bitdex] == least }
    end
end

puts oxygen.first.join("").to_i(2) * co2.first.join("").to_i(2)
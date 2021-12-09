input = File.read("input")

# part 1
lines = input.split("\n").map {|line| line.split(" | ").map {|x| x.split(" ") } }
puts lines.map {|(signal, output)| output.count {|digit| [2, 4, 3, 7].includes?(digit.size) } }.sum

# part 2
sum = lines.map do |(signal, output)|
    known, remaining = signal.partition {|x| [2, 4, 3, 7].includes?(x.size) }
    one, four, seven, eight = [2, 4, 3, 7].map {|n| known.find("") {|s| s.size == n }.chars.to_set }
    three = remaining.select {|x| x.size == 5 }.find("") {|x| (x.chars.to_set - one).size == 3 }.chars.to_set
    six = remaining.select {|x| x.size == 6 }.find("") {|x| (x.chars.to_set - one).size == 5 }.chars.to_set
    nine = remaining.select {|x| x.size == 6 }.find("") {|x| (x.chars.to_set - four).size == 2 }.chars.to_set
    zero = remaining.select {|x| x.size == 6 }.find("") {|x| x.chars.to_set != nine && x.chars.to_set != six }.chars.to_set
    two = remaining.select {|x| x.size == 5 }.find("") {|x| (x.chars.to_set - four).size == 3 }.chars.to_set
    five = remaining.select {|x| x.size == 5 }.find("") {|x| x.chars.to_set != two && x.chars.to_set != three }.chars.to_set

    digit_map = [zero, one, two, three, four, five, six, seven, eight, nine]
    number = output.map {|digit| digit_map.index {|map| digit.chars.to_set == map } }.join.to_i
end.sum
puts sum
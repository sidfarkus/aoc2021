# part 1
sum = 0
File.read("input").split("\n").map(&.to_i).each_cons_pair {|a,b| sum += 1 if b > a }
puts sum

# part 2
sum = 0
lastsum = 9999999999
File.read("input").split("\n").map(&.to_i).each_cons(3, true) {|window| sum += 1 if window.sum > lastsum; lastsum = window.sum }
puts sum
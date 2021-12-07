
# part 1
crabs = File.read("input").split(",").map(&.to_i)
positions = crabs.max
min_fuel = positions.times.reduce(Int32::MAX) do |min_fuel, position|
    [crabs.map {|c| (c - position).abs }.sum, min_fuel].min
end
puts min_fuel

# part 2
min_fuel = positions.times.reduce(Int32::MAX) do |min_fuel, position|
    [crabs.map {|c| n = (c - position).abs; n * (n + 1) // 2 }.sum, min_fuel].min
end
puts min_fuel
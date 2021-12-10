
map = File.read("input").split("\n").map &.chars.map(&.to_i8)
width, height = { map.first.size, map.size }
low = 0
low_spots = [] of {Int32, Int32}
(0...width).to_a.each_cartesian((0...height).to_a) do |(x, y)|
    top, bottom = {y - 1 < 0 ? [] of Int8 : map[y - 1], y + 1 >= map.size ? [] of Int8 : map[y + 1]}
    neighbors = [map[y][x - 1]?, map[y][x + 1]?, top[x]?, bottom[x]?]
    cur = map[y][x]
    if neighbors.all? {|n| (!n.nil? && n > cur) || n.nil?}
        low += cur + 1
        low_spots.push({x, y})
    end
end

puts low

basins = Array(Set({Int32, Int32})).new(low_spots.size) { Set({Int32, Int32}).new }
candidates = low_spots.map_with_index {|(x, y), i| {i, x, y}}
while candidates.any?
    id, x, y = candidates.pop
    next if basins[id].includes?({x, y})
    basins[id].add({x, y})
    cur_height = map[y][x]

    [{x - 1, y}, {x + 1, y}, {x, y - 1}, {x, y + 1}].each do |(newx, newy)|
        if newy >= 0 && newy < height && newx >= 0 && newx < width
            new_height = map[newy][newx]
            candidates.push({id, newx, newy}) if new_height < 9
        end
    end
end
puts basins.map(&.size).sort![-3..].product
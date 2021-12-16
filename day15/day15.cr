lines = File.read("input").lines

map = lines.map(&.chars.map(&.to_i))
width, height = map.first.size, map.size
part2 = true # toggle for part 2

lookup_map = -> (x : Int32, y : Int32) {
    if part2
        val = map[y % height][x % width] + x // width + y // height
        val > 9 ? val - 9 : val
    else
        map[y][x]
    end
}

cave_width, cave_height = part2 ? {5 * width, 5 * height} : {width, height}
visited = Array(Array(Int32)).new(cave_height, Array(Int32).new).fill(0) {|_| Array(Int32).new(cave_width, Int32::MAX) }
candidates = (0...cave_width).to_a.cartesian_product((0...cave_height).to_a).to_set
visited[0][0] = 0

while candidates.any?
    c = candidates.min_by {|(x, y)| visited[y][x] }
    candidates.delete(c)
    x, y = c
    [{0, 1}, {1, 0}, {-1, 0}, {0, -1}].each do |(xoff, yoff)|
        newx, newy = x + xoff, y + yoff
        next if newx < 0 || newy < 0 || newx >= cave_width || newy >= cave_height

        visited[newy][newx] = [visited[y][x] + lookup_map.call(newx, newy), visited[newy][newx]].min
        {newx, newy}
    end
    break if x == cave_width - 1 && y == cave_height - 1
end

puts visited.last.last



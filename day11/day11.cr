map_front = File.read("input").lines.map(&.chars.map(&.to_i))
map_back = map_front.clone

def flash(x, y, map, already_flashed)
    [0, 1, -1].cartesian_product([0, 1, -1]).each do |(xoff, yoff)|
        nx, ny = x + xoff, y + yoff
        map[ny][nx] += 1 if (xoff != 0 || yoff != 0) && nx > -1 && ny > -1 && nx < map.first.size && ny < map.size && !already_flashed.includes?({nx, ny})
    end
end

flashes = 0
(1..).each do |step|
    flashed = Set({Int32, Int32}).new
    map_front.each {|row| row.fill(0) {|i| row[i] + 1} }

    while map_front != map_back
        flashed_this_iteration = Set({Int32, Int32}).new
        map_front.each_with_index do |row, y|
            row.each_with_index do |nrg, x|
                if nrg > 9
                    map_back[y][x] = 0
                    flashed_this_iteration.add({x, y})
                else
                    map_back[y][x] = map_front[y][x]
                end
            end
        end

        flashed.concat(flashed_this_iteration)
        flashed_this_iteration.each {|(x, y)| flashes += 1; flash(x, y, map_back, flashed)}
        map_front, map_back = map_back, map_front
    end

    if flashed.size == map_front.size * map_front.first.size
        puts "all flash on step #{step}"
        break
    end
    puts flashes if step == 100
end

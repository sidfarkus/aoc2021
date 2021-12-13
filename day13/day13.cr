lines = File.read("input").lines
dots = lines.select {|x| x.match(/\d+,\d+/) }.map(&.split(",").map(&.to_i)).to_set
instructions = lines.select {|x| x.starts_with?("fold") }.map {|x| dir, coord = x.split("="); {dir[-1], coord.to_i} }

def pm(map, width, height)
    (0..height).each do |y|
        (0..width).each do |x|
            if map.includes?([x, y])
                print "#"
            else
                print "."
            end
        end
        puts ""
    end
end

width, height = dots.max_of(&.first), dots.max_of(&.last)
instructions.each do |(axis, location)|
    if axis == 'x'
        dots = dots.map {|(x, y)| x > location ? [(width - x) % location, y] : [x, y] }.to_set
        width = width // 2 - 1
    else
        dots = dots.map {|(x, y)| y > location ? [x, (height - y) % location] : [x, y] }.to_set
        height = height // 2 - 1
    end
end

puts dots.size
pm dots, width, height
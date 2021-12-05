
# parts 1 & 2 merged
segments = File.read("input").split("\n").map{|seg| seg.split(" -> ").map {|x| x.split(",").map(&.to_i) } }
width = segments.max_of {|segment| segment.map(&.first).max } + 1
height = segments.max_of {|segment| segment.map(&.last).max } + 1
board = Array(Int32).new(width * height, 0)

segments.each do |segment|
    x1, y1, x2, y2 = segment.sort_by(&.first).flatten
    if x1 == x2
        [y1,y2].min.step(to: [y1,y2].max).each do |y|
            board[x1 + y * width] += 1
        end
    elsif y1 == y2
        (x1..x2).each do |x|
            board[x + y1 * width] += 1
        end
    else
        y, ystep = y1 < y2 ? {y1, 1} : {y1, -1}
        (x1..x2).each do |x|
            board[x + y * width] += 1
            y += ystep
        end
    end
end
puts board.select {|x| x > 1 }.size

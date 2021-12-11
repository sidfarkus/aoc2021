require "big"

lines = File.read("input").lines

braces = "{}[]<>()".chars
scores = {')' => 3, ']' => 57, '}' => 1197, '>' => 25137}
line_scores = lines.map do |line|
    unresolved = Array(Char).new
    part1 = 0
    line.chars.each do |char|
        index = braces.index(char) || raise RuntimeError.new
        if index.odd? && braces.index(unresolved.pop).try(&.!=(index - 1))
            part1 = scores[char]
            break
        else
            unresolved.push(char)
        end
    end

    part2 = 0
    if part1 == 0
        str = unresolved.reverse!.map {|c| braces.index(c).try {|i| braces[i + 1]} }
        part2 = str.reduce(0.to_big_i) do |score, char|
            score * 5 + (")]}>".index(char || 'x') || 0) + 1
        end
    end
    {part1, part2}
end

puts line_scores.map(&.first).sum
part2 = line_scores.map(&.last).select(&.>(0)).sort!
puts part2[part2.size // 2]
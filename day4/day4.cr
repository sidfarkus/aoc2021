# part 1

numbers, rest = File.read("input").split("\n", 2)
board_strings = rest.split("\n\n")
boards = board_strings.map {|b| b.split("\n", remove_empty: true).map {|row| row.split(/\s+/, remove_empty: true).map(&.to_i)} }
numbers = numbers.split(",").map(&.to_i)

def wins?(board)
    board.any? {|row| row.all?(&.negative?)} ||
    board.transpose.any? {|col| col.all?(&.negative?)}
end

def check_nums(nums, boards)
    nums.each do |draw|
        boards.each do |b|
            b.each do |row|
                spot = row.index(draw)
                row[spot] = -row[spot].abs unless spot.nil?
            end
            return {draw, b} if wins?(b)
        end
    end
    raise RuntimeError.new # hint for the type checker
end
draw, board = check_nums(numbers, boards)
puts draw * board.flatten.select(&.positive?).sum

# part 2

boards.each {|b| b.each_with_index {|row, i| row[i] = row[i].abs}}
while boards.size > 0
    draw, winning_board = check_nums(numbers, boards)
    puts draw * winning_board.flatten.select(&.positive?).sum if boards.size == 1
    boards.delete(winning_board)
end

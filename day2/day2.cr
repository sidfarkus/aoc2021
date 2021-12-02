# part 1
coord = {"forward" => 0, "depth" => 0}
File.read("input").split("\n").each do |a|
    dir, num = a.split(" ")
    coord[dir != "forward" ? "depth" : dir] += num.to_i * (dir == "up" ? -1 : 1)
end
puts coord["forward"] * coord["depth"]

# part 2
forward = depth = aim = 0
File.read("input").split("\n").each do |a|
    dir, num = a.split(" ")
    if dir == "forward"
        forward += num.to_i
        depth += num.to_i * aim
    else
        aim += num.to_i * (dir == "up" ? -1 : 1)
    end
end
puts forward * depth
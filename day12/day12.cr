lines = File.read("input").lines
graph = lines.reduce(Hash(String, Array(String)).new {|h, k| h[k] = [] of String}) do |adj, line|
    v1, v2 = line.split("-")
    adj[v1].push(v2)
    adj[v2].push(v1)
    adj
end

# flip for part2
part2 = false
paths = 0
to_visit = [{"start", Set(String).new(part2 ? [] of String : ["2nd"])}]

def can_visit(n, visited)
    n.match(/[A-Z]+/) || (n.match(/[a-z]+/) && (!visited.includes?(n) || !visited.includes?("2nd"))) && n != "start"
end

while to_visit.any?
    node, small_rooms_visited = to_visit.pop
    neighbors = graph[node]
    if node == "end"
        paths += 1
        next
    else
        if node.match(/[a-z+]/)
            if part2 && small_rooms_visited.includes?(node)
                small_rooms_visited.add("2nd")
            else
                small_rooms_visited.add(node)
            end
        end
    end
    eligible = neighbors.select {|n| can_visit(n, small_rooms_visited) }.map {|n| {n, small_rooms_visited.clone}}
    to_visit.concat(eligible)
end

puts paths
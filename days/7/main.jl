using DataStructures

trial = Int64[16, 1, 2, 0, 4, 2, 7, 1, 2, 14]

input = map(s -> parse(Int64, s), split(read("input.txt", String), ","))
counts = Dict(counter(input))

max_position = max(keys(counts)...)
costs = zeros(Int64, max_position+1)
for target in 0:max_position
  for (start, total) in counts
    costs[target+1] += (abs(target - start) * total)
  end
end

println("Part 1: ", min(costs...))

function triangular(n::Int64)
  return sum(1:n)
end

costs = zeros(Int64, max_position+1)
for target in 0:max_position
  for (start, total) in counts
    costs[target+1] += (triangular(abs(target - start)) * total)
  end
end

println("Part 2: ", min(costs...))

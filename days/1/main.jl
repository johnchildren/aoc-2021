inputs = map(s -> parse(Int64, s), readlines(open("input.txt", "r")))

part1 = foldl(((s, a), b) -> a < b ? (s+1, b) : (s, b), inputs, init=(-1, 0))[1]

println("Part 1: ", part1)

using IterTools;

part2 = foldl(((s, a), b) -> sum(a) < sum(b) ? (s+1, b) : (s, b), IterTools.partition(inputs, 3, 1), init=(-1, (0, 0, 0)))[1]

println("Part 2: ", part2)

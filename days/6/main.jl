input = map(s -> parse(Int64, s), split(read("input.txt", String), ","))
initial = reduce((arr, x) -> 
               begin
                 arr[x+1] += 1
                 return arr
               end, input, init=zeros(Int64, 9))

trial = Int64[0, 1, 1, 2, 1, 0, 0, 0, 0]
days = 256

state = initial
for _ in 1:days
  ready = state[1]
  state[1:8] = state[2:9]
  state[7] += ready
  state[9] = ready
end

println("Part 1: ", sum(state))

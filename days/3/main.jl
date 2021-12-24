function parse_line(line::String)
    return BitArray(map(c -> parse(Bool, c), collect(line)))
end


function binary_to_int(binary::BitArray)
    return parse(Int64, foldl((s, b) -> s * string(Int(b)), binary, init=""), base=2)
end


inputs = map(parse_line, readlines(open("input.txt", "r")))
inputs_length = length(inputs)
inputs_matrix = hcat(inputs...)

col_sums = sum(eachcol(inputs_matrix))
frequency = map(total -> total / inputs_length, col_sums)
most_common_readout = BitArray(map(f -> convert(Bool, round(f)), frequency))
least_common_readout = map(!, most_common_readout)

gamma = binary_to_int(most_common_readout)
epsilon = binary_to_int(least_common_readout)

println("part 1: ", gamma * epsilon)

oxygen_rating = inputs_matrix
for i in 1:inputs_length
    total_candidates = size(oxygen_rating)[2]
    if total_candidates == 1
        break
    end

    most_common = convert(Bool, round(sum(oxygen_rating[i, :]) / total_candidates, RoundNearestTiesUp))

    global oxygen_rating = oxygen_rating[:, oxygen_rating[i,:] .== most_common]
end

co2_rating = inputs_matrix
for i in 1:inputs_length
    total_candidates = size(co2_rating)[2]
    if total_candidates == 1
        break
    end

    least_common = convert(Bool, round(1 - sum(co2_rating[i, :]) / total_candidates, RoundNearest))

    global co2_rating = co2_rating[:, co2_rating[i,:] .== least_common]
end

println("Part 2: ", binary_to_int(oxygen_rating) * binary_to_int(co2_rating))

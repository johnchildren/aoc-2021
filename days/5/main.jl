struct Line
    start_x::Int64
    start_y::Int64
    end_x::Int64
    end_y::Int64
end

function parse_line(line::String)
  m = match(r"(\d+),(\d+) -> (\d+),(\d+)", line)
  # Account for Julia being 1-indexed
  Line(
       parse(Int64, m[1]) + 1,
       parse(Int64, m[2]) + 1,
       parse(Int64, m[3]) + 1,
       parse(Int64, m[4]) + 1,
      )
end

function is_horizontal_or_vertical(line::Line)
    if line.start_x == line.end_x
        return true
    end

    if line.start_y == line.end_y
        return true
    end

    return false
end

lines = map(parse_line, readlines(open("input.txt", "r")))
max_x = max(map(x::Line -> max(x.start_x, x.end_x), lines)...)
max_y = max(map(x::Line -> max(x.start_y, x.end_y), lines)...)

grid = zeros(Int64, max_x, max_y)

for line in filter(is_horizontal_or_vertical, lines)
    start_x = line.start_x
    start_y = line.start_y
    end_x = line.end_x
    end_y = line.end_y
    
    if start_x > end_x || start_y > end_y
        start_x, end_x = end_x, start_x
        start_y, end_y = end_y, start_y
    end

    x_slice = start_x:end_x
    y_slice = start_y:end_y
    grid[y_slice, x_slice] = map(x -> x + 1, grid[y_slice, x_slice])
end

println("Part 1: ", count(v -> v >= 2, grid))

for line in filter(!is_horizontal_or_vertical, lines)
    start_x = line.start_x
    start_y = line.start_y
    end_x = line.end_x
    end_y = line.end_y

    if start_x > end_x
        start_x, end_x = end_x, start_x
        start_y, end_y = end_y, start_y
    end

    y = start_y
    for x in start_x:end_x
        grid[y, x] += 1
        if y < end_y
            y += 1
        elseif y > end_y
            y -= 1
        end
    end
end

println("Part 2: ", count(v -> v >= 2, grid))

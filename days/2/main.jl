using Match

const directions = Set([:forward, :down, :up])

struct Command
  direction::Symbol
  distance::Int64
end

struct Position
    horizontal::Int64
    depth::Int64
    aim::Int64
end

function parse_command(s::String)
    parts = split(s, " ")
    dir = parts[1]
    x = parse(Int64, parts[2])
    return @match dir begin
        "forward" => Command(:forward, x)
        "down" => Command(:down, x)
        "up" => Command(:up, x)
     end
end

function run_command1(position::Position, command::Command)
    hori = position.horizontal
    depth = position.depth
    aim = position.aim
    @match command begin
        Command(:forward, x) => Position(hori + x, depth, aim)
        Command(:down, x) => Position(hori, depth + x, aim)
        Command(:up, x) => Position(hori, depth - x, aim)
    end
end

function run_command2(position::Position, command::Command)
    hori = position.horizontal
    depth = position.depth
    aim = position.aim
    @match command begin
        Command(:forward, x) => Position(hori + x, depth + (aim * x), aim)
        Command(:down, x) => Position(hori, depth, aim + x)
        Command(:up, x) => Position(hori, depth, aim - x)
    end
end



inputs = map(parse_command, readlines(open("input.txt", "r")))

final_position = foldl(run_command1, inputs, init=Position(0, 0, 0))
part1 = final_position.horizontal * final_position.depth
println("Part 1: ", part1)

final_position = foldl(run_command2, inputs, init=Position(0, 0, 0))
part2 = final_position.horizontal * final_position.depth
println("Part 2: ", part2)

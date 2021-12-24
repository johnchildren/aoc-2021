heightmap = transpose(hcat(
                        map(x -> 
                            map(y -> 
                                parse(Int64, y), 
                                collect(x)), 
                            readlines(open("input.txt", "r")))...))

(y_max, x_max) = size(heightmap)

risk_sum = 0
low_points = []
for y in 1:y_max
  for x in 1:x_max
    target = heightmap[y, x]
    low = true

    if y != 1 && heightmap[y-1,x] <= target
      low = false
    end

    if y != y_max && heightmap[y+1,x] <= target
      low = false
    end

    if x != 1 && heightmap[y,x-1] <= target
      low = false
    end

    if x != x_max && heightmap[y,x+1] <= target
      low = false
    end

    if low
      global risk_sum += target + 1
      push!(low_points, (x, y))
    end
  end
end

println("Part 1: ", risk_sum)

top_3_basins = [0, 0, 0]
for (start_x, start_y) in low_points
  start = heightmap[start_y,start_x]
  basin_size = 0
  checked = Set()
  to_check = [(start_x+1, start_y), (start_x-1, start_y), (start_x, start_y+1), (start_x, start_y-1)]

  while length(to_check) > 0
    (x, y) = popfirst!(to_check)
    if x == 0 || y == 0 || x > x_max || y > y_max
      continue
    end

    if heightmap[y, x] == 9
      continue
    end

    if (x, y) in checked
      continue
    end

    basin_size += 1
    push!(checked, (x, y))
    push!(to_check, (x+1, y), (x-1, y), (x, y+1), (x,y-1))
  end

  if basin_size > top_3_basins[1]
    top_3_basins[1], basin_size = basin_size, top_3_basins[1]
  end
  if basin_size > top_3_basins[2]
    top_3_basins[2], basin_size = basin_size, top_3_basins[2]
  end
  if basin_size > top_3_basins[3]
    top_3_basins[3], basin_size = basin_size, top_3_basins[3]
  end
end

println("Part 2: ", reduce(*, top_3_basins))

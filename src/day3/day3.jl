module day3

using DelimitedFiles
const input = readdlm(joinpath(@__DIR__, "input.txt"), ',', String)
const dictDir = Dict('U' => (1, 0), 'D' => (-1, 0), 'L' => (0, -1), 'R' => (0, 1))

function createWire(moves)
    x = [(0, 0)]
    for m in moves
        m == "" && break
        d, len = m[1], parse(Int, m[2:end])
        push!(x, x[end] .+ (len .* dictDir[d]))
    end
    x
end

function intersects((a1, a2), (b1, b2))
    a1[1] == a2[1] && b1[1] == b2[1] && return (0, 0) # both segments are vertical
    a1[2] == a2[2] && b1[2] == b2[2] && return (0, 0) # both segments are horizontal
    
    # # y
    # # ^      b2
    # # |      |
    # # | a1---x---a2
    # # |      |
    # # |      b1
    # # |-------------> x
    # Reorder segments and points to have them ordered like in the figure
    abs(a1[1] - a2[1]) == 0 && ((a1, a2, b1, b2) = (b1, b2, a1, a2))
    a1[1] < a2[1] || ((a1, a2) = (a2, a1))
    b1[2] < b2[2] || ((b1, b2) = (b2, b1))

    !(a1[1] <= b1[1] <= a2[1]) && return (0, 0)
    !(b1[2] <= a1[2] <= b2[2]) && return (0, 0)
    return (b1[1], a1[2])
end

function findAllIntersections(wire1, wire2)
    intersections = Tuple{Int, Int}[]
    for i = 1:length(wire1) - 1
        segment_i = wire1[i], wire1[i + 1]
        for j = 1:length(wire2) - 1
            segment_j = wire2[j], wire2[j + 1]
            intersection = intersects(segment_i, segment_j)
            intersection != (0, 0) && push!(intersections, intersection)
        end
    end
    intersections
end

function part1(input)
    wire1 = createWire(@view input[1, :])
    wire2 = createWire(@view input[2, :])
    intersections = findAllIntersections(wire1, wire2)
    minimum(point -> abs(point[1]) + abs(point[2]), intersections)
end

function findIntersectionMinLength(wire1, wire2)
    minLength = typemax(Int)
    len_i = 0
    for i = 1:length(wire1) - 1
        len_j = 0
        segment_i = wire1[i], wire1[i + 1]
        for j = 1:length(wire2) - 1
            segment_j = wire2[j], wire2[j + 1]
            intersection = intersects(segment_i, segment_j)
            if intersection != (0, 0)
                len = len_i + len_j + segmentLength((wire1[i], intersection)) + segmentLength((wire2[j], intersection))
                minLength = min(len, minLength)
            end
            len_j += segmentLength(segment_j)
            len_i + len_j >= minLength && break
        end
        len_i += segmentLength(segment_i)
    end
    minLength
end

segmentLength((a1, a2)) = abs(a1[1] - a2[1]) + abs(a1[2] - a2[2])

function part2(input)
    wire1 = createWire(@view input[1, :])
    wire2 = createWire(@view input[2, :])
    findIntersectionMinLength(wire1, wire2)
end

# using Plots
# wire1 = aoc19.day3.createWire(@view aoc19.day3.input[1, :])
# wire2 = aoc19.day3.createWire(@view aoc19.day3.input[2, :])
# plot( map(first, wire1), map(last, wire1))
# plot!(map(first, wire2), map(last, wire2))

end
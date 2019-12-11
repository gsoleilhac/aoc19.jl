module day11

import ..aoc19: run_program!
using DelimitedFiles, UnicodePlots, REPL

readInput() = parse.(Int, split(readline(joinpath(@__DIR__,"input.txt")), ','))

const UP = (1, 0)
const RIGHT = (0, 1)
const DOWN = (-1, 0)
const LEFT = (0, -1)
turnLeft(d) = d == UP ? LEFT : (d == RIGHT ? UP : (d == DOWN ? RIGHT : DOWN))
turnRight(d) = d == UP ? RIGHT : (d == RIGHT ? DOWN : (d == DOWN ? LEFT : UP))

function part1(data = readInput())
    pos = (0, 0)
    dir = UP
    painted = Dict{Tuple{Int, Int}, Int}()

    input = Channel{Int}(Inf)
    output = Channel{Int}(Inf)
    task = @async run_program!(data, input, output)

    while !istaskdone(task)
        put!(input, get(painted, pos, 0))
        color = take!(output)
        turn = take!(output)
        painted[pos] = color # paint
        dir = turn == 0 ? turnLeft(dir) : turnRight(dir) # turn
        pos = pos .+ dir # move forward
    end

    length(painted)
end

function part2(data = readInput())
    pos = (0, 0)
    dir = UP
    painted = Dict((0, 0) => 1)

    input = Channel{Int}(Inf)
    output = Channel{Int}(Inf)
    task = @async run_program!(data, input, output)

    while !istaskdone(task)
        put!(input, get(painted, pos, 0))
        color = take!(output)
        turn = take!(output)
        painted[pos] = color # paint
        dir = turn == 0 ? turnLeft(dir) : turnRight(dir) # turn
        pos = pos .+ dir # move forward
    end

    white = filter(p -> p.second == 1, painted)

    scatterplot(last.(keys(white)), first.(keys(white)), xlim=extrema(last.(keys(painted))),
        ylim=extrema(first.(keys(painted))), height = 5, width = 70, color = :blue, canvas = BlockCanvas)

end

end
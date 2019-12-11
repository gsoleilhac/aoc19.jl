module day11

import ..aoc19
using DelimitedFiles, UnicodePlots, REPL

readInput() = parse.(Int, split(readline(joinpath(@__DIR__,"input.txt")), ','))

function part1(data = readInput())
    data
end

function part2(data)
   
end

end
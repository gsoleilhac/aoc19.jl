module day9

import ..aoc19: run_program!
using DelimitedFiles

readInput() = readdlm(joinpath(@__DIR__, "input.txt"), ',', Int) |> vec

function part1(data, programInput = 1)
    output = Channel{Int}(Inf)
    input = Channel{Int}(Inf)
    put!(input, programInput)
    run_program!(data, input, output)
    close(output)
    [o for o in output]
end

part2(data) = part1(data, 2)

end
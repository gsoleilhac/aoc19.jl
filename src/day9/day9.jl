module day9

import ..aoc19
using DelimitedFiles

readInput() = readdlm(joinpath(@__DIR__, "input.txt"), ',', Int) |> vec

function part1(data = readInput(), programInput = 1)
    output = Channel{Int}(Inf)
    input = Channel{Int}(Inf)
    put!(input, programInput)
    aoc19.run_program!(data, input, output)
    close(output)
    [o for o in output]
end

part2(data = readInput()) = part1(data, 2)

end
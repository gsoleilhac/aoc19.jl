module day5

using ..aoc19: run_program!

readInput() = parse.(Int,split(readline(joinpath(@__DIR__, "input.txt")), ','))

function part1(data, userInput = 1)
    output = Channel{Int}(Inf)
    input = Channel{Int}(Inf)
    put!(input, userInput)
    run_program!(copy(data), input, output)
    val = take!(output)
    while val == 0
        val = take!(output)
    end
    val
end

part2(input) = part1(input, 5)

end
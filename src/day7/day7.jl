module day7

using ..aoc19: run_program!

using DelimitedFiles, Combinatorics

readInput() = readdlm(joinpath(@__DIR__, "input.txt"), ',', Int) |> vec

part1(input = readInput()) = maximum(run_amplifiers(input, p) for p in permutations(0:4))

part2(input = readInput()) = maximum(run_amplifiers(input, p) for p in permutations(5:9))

function run_amplifiers(input, phases)
    channels = [Channel{Int}(2) for i = 1:5]
    put!.(channels, phases) #phase setting
    put!(first(channels), 0) #initial input
    tasks = [@async run_program!(copy(input), channels[i], channels[mod1(i+1, 5)]) for i = 1:5]
    wait.(tasks)
    take!(first(channels))
end

end
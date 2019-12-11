module day2

using ..aoc19: run_program!

readInput() = parse.(Int,split(readline(joinpath(@__DIR__, "input.txt")), ','))

function part1(input = readInput())
    p = copy(input)
    p[2], p[3] = 12, 2
    run_program!(p)[0]
end

function part2(input = readInput())
    for noun = 0:99, verb = 0:99
        p = copy(input)
        p[2], p[3] = noun, verb
        run_program!(p)[0] == 19690720 && return (100*noun + verb)
    end
end

end
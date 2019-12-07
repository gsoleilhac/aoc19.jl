module day7

using DelimitedFiles, Combinatorics

const input = readdlm(joinpath(@__DIR__, "input.txt"), ',', Int) |> vec

part1(input) = maximum(run_amplifiers(input, p) for p in permutations(0:4))

part2(input) = maximum(run_amplifiers(input, p) for p in permutations(5:9))

function run_amplifiers(input, phases)
    channels = [Channel{Int}(2) for i = 1:5]
    put!.(channels, phases) #phase setting
    put!(first(channels), 0) #initial input
    tasks = [@async run_program!(copy(input), channels[i], channels[mod1(i+1, 5)]) for i = 1:5]
    wait.(tasks)
    take!(first(channels))
end

function run_program!(program, input, output)
    index = 1
    while program[index] != 99
        index = process_opcode!(index, program, input, output)
    end
end

function process_opcode!(index, p, input, output)
    opcode = p[index] % 100
    modes = Dict( i => v for (i,v) in enumerate(digits(p[index])[3:end]))
    if opcode == 1
        a, b = get(p, index + 1, modes, 1), get(p, index + 2, modes, 2)
        p[p[index + 3] + 1] = a + b
        return index + 4
    elseif opcode == 2
        p[p[index + 3] + 1] = get(p, index + 1, modes, 1) * get(p, index + 2, modes, 2)
        return index + 4
    elseif opcode == 3
        p[p[index + 1] + 1] = take!(input)
        return index + 2
    elseif opcode == 4
        put!(output, get(p, index + 1, modes, 1))
        return index + 2
    elseif opcode == 5
        get(p, index + 1, modes, 1) != 0 && return get(p, index + 2, modes, 2) + 1
        return index + 3
    elseif opcode == 6
        get(p, index + 1, modes, 1) == 0 && return get(p, index + 2, modes, 2) + 1
        return index + 3
    elseif opcode == 7
        p[p[index + 3] + 1] = get(p, index + 1, modes, 1) < get(p, index + 2, modes, 2) ? 1 : 0
        return index + 4
    elseif opcode == 8
        p[p[index + 3] + 1] = get(p, index + 1, modes, 1) == get(p, index + 2, modes, 2) ? 1 : 0
        return index + 4
    else
        @error("invalid opcode at index $index : $(p[index])")
        return 0
    end
end

end
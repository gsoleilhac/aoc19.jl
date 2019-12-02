module day2

const input = parse.(Int,split(readline(joinpath(@__DIR__, "input.txt")), ','))

function part1(input)
    input[2], input[3] = 12, 2
    process_input!(copy(input)) |> first
end

function process_input!(input)
    index = 1
    while input[index] != 99
        process_opcode!(index, input)
        index += 4
    end
    input
end

function process_opcode!(index, p)
    if p[index] == 1
        p[p[index + 3] + 1] = p[p[index + 1] + 1] + p[p[index + 2] + 1]
    elseif p[index] == 2
        p[p[index + 3] + 1] = p[p[index + 1] + 1] *  p[p[index + 2] + 1]
    else
        @error "invalid opcode at index $index : $(p[index])"
    end
end

function part2(input)
    for noun = 0:99, verb = 0:99
        p = copy(input)
        p[2], p[3] = noun, verb
        first(process_input!(p)) == 19690720 && return (100*noun + verb)
    end
end

end
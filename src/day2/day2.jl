module day2

const input = parse.(Int,split(readline(joinpath(@__DIR__, "input.txt")), ','))

function part1(input)
    p = copy(input)
    p[2], p[3] = 12, 2
    first(process!(p))
end

function process!(p)
    index = 1
    while p[index] != 99
        process_opcode!(index, p)
        index += 4
    end
    p
end

function process_opcode!(index, p)
    if p[index] == 1
        p[p[index + 3] + 1] = p[p[index + 1] + 1] + p[p[index + 2] + 1]
    elseif p[index] == 2
        p[p[index + 3] + 1] = p[p[index + 1] + 1] *  p[p[index + 2] + 1]
    else
        error("invalid opcode at index $index : $(p[index])")
    end
end

function part2(input)
    for noun = 0:99, verb = 0:99
        p = copy(input)
        p[2], p[3] = noun, verb
        first(process!(p)) == 19690720 && return (100*noun + verb)
    end
end

end
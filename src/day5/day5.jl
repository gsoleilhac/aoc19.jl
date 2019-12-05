module day5

const input = parse.(Int,split(readline(joinpath(@__DIR__, "input.txt")), ','))

function part1(input, userInput = 1)
    p = copy(input)
    out = Ref{Int}()
    index = 1
    while p[index] != 99
        index = process_opcode!(index, p, out, userInput = userInput)
    end
    out[]
end

function Base.get(p::Vector{Int}, i::Int, modes::Dict{Int, Int}, ind_mode::Int) 
    m = get(modes, ind_mode, 0)
    return m == 0 ? p[p[i] + 1] : p[i]
end

function process_opcode!(index, p, output ; userInput = readline())
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
        p[p[index + 1] + 1] = userInput
        return index + 2
    elseif opcode == 4
        out = get(p, index + 1, modes, 1)
        # println("output : ", out)
        output[] = out
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

part2(input) = part1(input, 5)

end
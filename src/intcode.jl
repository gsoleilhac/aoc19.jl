function run_program!(program, input = Channel{Int}(), output=Channel{Int}())
    index = 1
    while program[index] != 99
        index = process_opcode!(index, program, input, output)
    end
end

function process_opcode!(index, p, input, output)
    opcode = p[index] % 100
    modes = Dict( i => v for (i,v) in enumerate(digits(p[index])[3:end]))
    if opcode == 1
        p[p[index + 3] + 1] = get(p, index + 1, modes, 1) + get(p, index + 2, modes, 2)
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

function Base.get(p::Vector{Int}, i::Int, modes::Dict{Int, Int}, ind_mode::Int) 
    m = get(modes, ind_mode, 0)
    return m == 0 ? p[p[i] + 1] : p[i]
end

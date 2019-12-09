function run_program!(p, input = Channel{Int}(), output=Channel{Int}())
    index = 0
    base = Ref(0)
    program = Dict((i-1)=>v for (i,v) in enumerate(p))
    while get(program, index, 0) != 99
        index = process_opcode!(index, program, input, output, base)
    end
    program
end

function process_opcode!(index, p, input, output, base)
    opcode = p[index] % 100
    modes = Dict( i => v for (i,v) in enumerate(digits(p[index])[3:end]))
    if opcode == 1
        ind = get(modes, 3, 0) == 0 ? p[index + 3] : p[index + 3] + base[]
        p[ind] = get(p, index + 1, modes, 1, base) + get(p, index + 2, modes, 2, base)
        return index + 4
    elseif opcode == 2
        ind = get(modes, 3, 0) == 0 ? p[index + 3] : p[index + 3] + base[]
        p[ind] = get(p, index + 1, modes, 1, base) * get(p, index + 2, modes, 2, base)
        return index + 4
    elseif opcode == 3
        ind = get(modes, 1, 0) == 0 ? p[index + 1] : p[index + 1] + base[]
        p[ind] = take!(input)
        return index + 2
    elseif opcode == 4
        put!(output, get(p, index + 1, modes, 1, base))
        return index + 2
    elseif opcode == 5
        get(p, index + 1, modes, 1, base) != 0 && return get(p, index + 2, modes, 2, base)
        return index + 3
    elseif opcode == 6
        get(p, index + 1, modes, 1, base) == 0 && return get(p, index + 2, modes, 2, base)
        return index + 3
    elseif opcode == 7
        ind = get(modes, 3, 0) == 0 ? p[index + 3] : p[index + 3] + base[]
        p[ind] = get(p, index + 1, modes, 1, base) < get(p, index + 2, modes, 2, base) ? 1 : 0
        return index + 4
    elseif opcode == 8
        ind = get(modes, 3, 0) == 0 ? p[index + 3] : p[index + 3] + base[]
        p[ind] = get(p, index + 1, modes, 1, base) == get(p, index + 2, modes, 2, base) ? 1 : 0
        return index + 4
    elseif opcode == 9
        base[] += get(p, index + 1, modes, 1, base)
        return index + 2
    else
        @error("invalid opcode at index $index : $(p[index])")
        return 0
    end
end

function Base.get(p::Dict{Int, Int}, i::Int, modes::Dict{Int, Int}, ind_mode::Int, base::Ref{Int})
    m = get(modes, ind_mode, 0)
    if m == 0
        # p[p[i]]
        return get(p, get(p, i, 0), 0)
    elseif m == 1
        # p[i]
        return get(p, i, 0)
    elseif m == 2
        # p[p[i] + base]
        return get(p, get(p, i, 0) + base[], 0)
    end
end

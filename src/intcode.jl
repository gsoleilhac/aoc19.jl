function run_program!(p, input = Channel{Int}(), output=Channel{Int}())
    index = 0
    base = Ref(0)
    modes = zeros(Int, 3)
    program = Dict((i-1)=>v for (i,v) in enumerate(p))
    while get(program, index, 0) != 99
        index = process_opcode!(index, program, input, output, base, modes)
    end
    program
end

function process_opcode!(index, p, input, output, base, modes)
    @inbounds begin
        opcode = p[index] % 100
        modes[1], modes[2], modes[3] = p[index] ÷ 100 % 10, p[index] ÷ 1000 % 10, p[index] ÷ 10000 % 10
        if opcode == 1
            ind = modes[3] == 0 ? p[index + 3] : p[index + 3] + base[]
            p[ind] = get(p, index + 1, modes, 1, base) + get(p, index + 2, modes, 2, base)
            return index + 4
        elseif opcode == 2
            ind = modes[3] == 0 ? p[index + 3] : p[index + 3] + base[]
            p[ind] = get(p, index + 1, modes, 1, base) * get(p, index + 2, modes, 2, base)
            return index + 4
        elseif opcode == 3
            ind = modes[1] == 0 ? p[index + 1] : p[index + 1] + base[]
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
            ind = modes[3] == 0 ? p[index + 3] : p[index + 3] + base[]
            p[ind] = get(p, index + 1, modes, 1, base) < get(p, index + 2, modes, 2, base) ? 1 : 0
            return index + 4
        elseif opcode == 8
            ind = modes[3] == 0 ? p[index + 3] : p[index + 3] + base[]
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
end

function Base.get(p::Dict{Int, Int}, i::Int, modes::Vector{Int}, ind_mode::Int, base::Ref{Int})
    m = modes[ind_mode]
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

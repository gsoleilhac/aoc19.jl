module day13

import ..aoc19: run_program!
using StaticArrays, Combinatorics, ProgressMeter

readInput() = parse.(Int, split(readline(joinpath(@__DIR__,"input.txt")), ','))

struct Out
    x::Int
    y::Int
    id::Int
end

function part1(data)
    input = Channel{Int}(Inf)
    output = Channel{Int}(Inf)
    run_program!(data, input, output)
    close(output)
    result = [o for o in output]
    count(==(2), (result[i] for i in 3:3:length(result)))
end

function part2(data)
    data[1] = 2 # insert 2 quarters
    
    input = Channel{Int}(Inf)
    output = Channel{Int}(Inf)
    game = @async run_program!(data, input, output)

    ball = Out(0, 0, 0)
    paddle = Out(0, 0, 0)
    score = Out(0, 0, 0)

    while !istaskdone(game)
        yield()
        result = Out[]
        while isready(output)
            push!(result, Out(take!(output), take!(output), take!(output)))
        end

        for out in result
            if out.id == 4
                ball = out
            elseif out.id == 3
                paddle = out
            elseif out.x == -1 && out.y == 0
                score = out
            end
        end
        
        if ball.x < paddle.x
            put!(input, -1)
        elseif ball.x > paddle.x
            put!(input, 1)
        else
            put!(input, 0)
        end
    end

    score.id
end


end
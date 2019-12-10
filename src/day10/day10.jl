module day10

import ..aoc19
using DelimitedFiles, UnicodePlots, REPL

input = permutedims(reshape([line[x] == '#' for line in readdlm(joinpath(@__DIR__, "input.txt")) for x in 1:length(line)], 24, 24), (2,1))

function part1(data)
    maxCount = 0
    for i = 1:size(data, 1), j= 1:size(data, 2)
        if data[i,j]
            maxCount = max(maxCount, length(countSight(data, i, j)))
        end
    end
    maxCount
end

function countSight(data, x, y)
    blocked = Set{Tuple{Int, Int}}()
    countAsteroid = 0
    counted = Vector{Tuple{Int, Int}}()
    for rayon = 1:max(size(data)...) - 1
        dx = -rayon
        for dy = -rayon:rayon
            if checkAsteroid(data, blocked, x, y, dx, dy)
                blockView!(data, blocked, x, y, dx, dy)
                countAsteroid += 1
                push!(counted, (x+dx, y+dy))
            end
        end
        dx = rayon
        for dy = -rayon:rayon
            if checkAsteroid(data, blocked, x, y, dx, dy)
                blockView!(data, blocked, x, y, dx, dy)
                countAsteroid += 1
                push!(counted, (x+dx, y+dy))
            end
        end
        dy = -rayon
        for dx = (-rayon+1):(rayon-1)
            if checkAsteroid(data, blocked, x, y, dx, dy)
                blockView!(data, blocked, x, y, dx, dy)
                countAsteroid += 1
                push!(counted, (x+dx, y+dy))
            end
        end
        dy = rayon
        for dx = (-rayon+1):(rayon-1)
            if checkAsteroid(data, blocked, x, y, dx, dy)
                blockView!(data, blocked, x, y, dx, dy)
                countAsteroid += 1
                push!(counted, (x+dx, y+dy))
            end
        end
    end

    # p = scatterplot([y], [size(data, 1) - x + 1], width = 2 * size(data, 1), height = 2 * size(data, 2), xlim=(1, size(data, 1)), ylim=(1, size(data, 2)), color = :blue, canvas = BlockCanvas)
    # p = scatterplot!(p, last.(counted), size(data, 1) .- first.(counted) .+ 1, color=:green)
    # p = scatterplot!(p, last.(blocked), size(data, 1) .- first.(blocked) .+ 1, color=:red)
    # display(p)

    counted
end

@inline checkAsteroid(data, blocked, x, y, dx, dy) = !((x+dx, y+dy) in blocked) && (1 <= x + dx <= size(data, 1)) && (1 <= y + dy <= size(data, 2)) && data[x+dx, y+dy]

function blockView!(data, blocked, x, y, dx, dy)
    xx = x + dx
    yy = y + dy
    step = gcd(abs(dx), abs(dy))
    dx, dy = dx ÷ step, dy ÷ step
    xx += dx
    yy += dy
    while 1 <= xx <= size(data, 1) && 1 <= yy <= size(data, 2)
        push!(blocked, (xx, yy))
        xx += dx
        yy += dy
    end
end

function part2(data, showplot = false, target = 200)
    data = copy(data)
    maxCount, maxI, maxJ = 0, 0, 0
    for i = 1:size(data, 1), j= 1:size(data, 2)
        if data[i,j]
            cpt = length(countSight(data, i, j))
            if cpt > maxCount
                maxCount, maxI, maxJ = cpt, i, j
            end
        end
    end

    vaporized = 0
    inSight = countSight(data, maxI, maxJ)
    while vaporized + length(inSight) < target
        for (i, j) in inSight
            data[i, j] = false
        end
        vaporized += length(inSight)
        inSight = countSight(data, maxI, maxJ)
    end
    
    sortRad(x) = begin
        d = atand((x .- (maxI, maxJ))...) .+ (3 * 90)
        d > 180 ? d - 360 : d
    end
    sort!(inSight, by = sortRad)

    if showplot
        p = scatterplot([maxJ], [size(data, 1) - maxI + 1], width = 2 * size(data, 1), height = 2 * size(data, 2), 
            xlim=(1, size(data, 1)), ylim=(1, size(data, 2)), color = :blue, canvas = BrailleCanvas)
        display(p)
        terminal = REPL.Terminals.TTYTerminal("", stdin, stdout, stderr)
        for asteroid in inSight
            sleep(0.1)
            REPL.Terminals.clear(terminal) 
            p = scatterplot!(p, [last(asteroid)], [size(data, 1) - first(asteroid) + 1], color=:green)
            display(p)
        end
    end

    x, y = inSight[target - 1] .- 1
    100y+x
end

end
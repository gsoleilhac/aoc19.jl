module day4

import StatsBase: countmap
const input = parse.(Int, split(readline(joinpath(@__DIR__, "input.txt")), '-'))

function part1(input, f = >=(2))
    cpt, d = 0, zeros(Int, 6)
    for x = first(input):last(input)
        digits!(d, x)
        issorted(d, rev=true) && any(f(v) for (k, v) in countmap(d)) && (cpt += 1)
    end
    cpt
end

part2(input) = part1(input, ==(2))

end
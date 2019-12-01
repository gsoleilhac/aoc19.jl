module aoc19

using BenchmarkTools, DataFrames

for d = 1:25
    include("day$d/day$d.jl")
end

formatTime(t) = (1e9 * t) |> BenchmarkTools.prettytime

function benchmarkAll()
    df = DataFrame(part1 = String[], part2 = String[])
    for day = 1:25
        !isdefined(@__MODULE__, Symbol("day$day")) && continue
        m = getproperty(@__MODULE__, Symbol("day$day"))
        p1 = @belapsed $m.part1($m.input)
        p2 = @belapsed $m.part2($m.input)
        push!(df, formatTime.((p1, p2)))
    end
    display(df)
end


end # module

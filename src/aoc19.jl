module aoc19

using BenchmarkTools
import DataFrames: DataFrame
import Dates

export part1, part2

for day = 1:25
    include("day$day/day$day.jl")
end

formatTime(t) = (1e9 * t) |> BenchmarkTools.prettytime

function benchmarkAll(; onlyOnce = false)
    df = DataFrame(part1 = String[], part2 = String[])
    for day = 1:25
        !isdefined(@__MODULE__, Symbol("day$day")) && continue
        m = getproperty(@__MODULE__, Symbol("day$day"))
        t1 = onlyOnce ? @elapsed(m.part1((m.input))) : @belapsed($m.part1($(m.input)))
        t2 = onlyOnce ? @elapsed(m.part2((m.input))) : @belapsed($m.part2($(m.input)))
        push!(df, formatTime.((t1, t2)))
    end
    df
end

function part1(; day::Int = min(Dates.day(Dates.today()), 25))
    m = getproperty(@__MODULE__, Symbol("day$day"))
    m.part1(m.input)
end

function part2(; day::Int = min(Dates.day(Dates.today()), 25))
    m = getproperty(@__MODULE__, Symbol("day$day"))
    m.part2(m.input)
end


end # module

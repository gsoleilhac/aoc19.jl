module aoc19

using BenchmarkTools, ProgressMeter
import DataFrames: DataFrame
import Dates, REPL

export part1, part2
export run_program!, process_opcode!

include("intcode.jl")
for day = 1:25
    include("day$day/day$day.jl")
end

formatTime(t) = (1e9 * t) |> BenchmarkTools.prettytime

function benchmarkAll(; onlyOnce = false)
    df = DataFrame(part1 = String[], part2 = String[])
    terminal = REPL.Terminals.TTYTerminal("", stdin, stdout, stderr)
    for day = 1:25
        !isdefined(@__MODULE__, Symbol("day$day")) && continue
        m = getproperty(@__MODULE__, Symbol("day$day"))
        t1 = onlyOnce ? @elapsed(m.part1((m.input))) : @belapsed($m.part1($(m.input)))
        t2 = onlyOnce ? @elapsed(m.part2((m.input))) : @belapsed($m.part2($(m.input)))
        push!(df, formatTime.((t1, t2)))
        if !onlyOnce
            REPL.Terminals.clear(terminal) 
            display(df)
        end
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

function benchmark(; day::Int = min(Dates.day(Dates.today()), 25))
    df = DataFrame(part1 = String[], part2 = String[])
    m = getproperty(@__MODULE__, Symbol("day$day"))
    t1 = @belapsed($m.part1($(m.input)))
    t2 = @belapsed($m.part2($(m.input)))
    push!(df, formatTime.((t1, t2)))
    df
end


end # module

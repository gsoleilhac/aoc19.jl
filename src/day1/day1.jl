module day1

using DelimitedFiles
readInput() = vec(readdlm(joinpath(@__DIR__, "input.txt"), Int))

fuelRequired(x) = x ÷ 3 - 2
part1(input = readInput()) = sum(fuelRequired, input)

function fuelRequired2(x)
    fuel = fuelRequired(x)
    fuel > 0 ? fuel + fuelRequired2(fuel) : 0
end
part2(input = readInput()) = sum(fuelRequired2, input)

end
module day1

using DelimitedFiles
const input = vec(readdlm(joinpath(@__DIR__, "input.txt"), Int))

fuelRequired(x) = x ÷ 3 - 2
part1(input) = sum(fuelRequired, input)

function fuelRequired2(x)
    fuel = fuelRequired(x)
    fuel > 0 ? fuel + fuelRequired2(fuel) : 0
end
part2(input) = sum(fuelRequired2, input)

end
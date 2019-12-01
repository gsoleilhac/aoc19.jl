module day1

using DelimitedFiles

const input = vec(readdlm(joinpath(@__DIR__, "input.txt"), Int))

fuelRequired(x) = x ÷ 3 - 2
part1(input) = sum(fuelRequired, input)

function fuelRequired2(x)
    fuel = totalFuel = fuelRequired(x)
    while fuel > 0
        fuel = max(0, fuelRequired(fuel))
        totalFuel += fuel
    end
    totalFuel
end
part2(input) = sum(fuelRequired2, input)

end
using aoc19
using Test

@testset "day1" begin
    @testset "part1" begin
        @test aoc19.day1.fuelRequired(12) == 2
        @test aoc19.day1.fuelRequired(14) == 2
        @test aoc19.day1.fuelRequired(1969) == 654
        @test aoc19.day1.fuelRequired(100756) == 33583
    end

    @testset "part2" begin
        @test aoc19.day1.fuelRequired2(14) == 2
        @test aoc19.day1.fuelRequired2(1969) == 966
        @test aoc19.day1.fuelRequired2(100756) == 50346
    end
end

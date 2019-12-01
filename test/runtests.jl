using aoc19
using Test, aoc19

@testset "aoc19.jl" begin
    @test_nowarn aoc19.benchmarkAll()
    @test aoc19.formatTime(0.1) == "100.000 ms"
end

@testset "day1" begin
    @testset "part1" begin
        @test aoc19.day1.fuelRequired(12) == 2
        @test aoc19.day1.fuelRequired(14) == 2
        @test aoc19.day1.fuelRequired(1969) == 654
        @test aoc19.day1.fuelRequired(100756) == 33583
        @test part1(day = 1) == 3373568
    end

    @testset "part2" begin
        @test aoc19.day1.fuelRequired2(14) == 2
        @test aoc19.day1.fuelRequired2(1969) == 966
        @test aoc19.day1.fuelRequired2(100756) == 50346
        @test part2(day = 1) == 5057481
    end
end

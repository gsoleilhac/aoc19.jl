using aoc19
using Test, aoc19

@testset "aoc19.jl" begin
    @test_nowarn aoc19.benchmarkAll(onlyOnce = true)
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


@testset "day1" begin
    @testset "part1" begin
        @test aoc19.day2.process!([1,9,10,3,2,3,11,0,99,30,40,50]) == [3500,9,10,70,2,3,11,0,99,30,40,50]
        @test aoc19.day2.process!([1,0,0,0,99]) == [2,0,0,0,99]
        @test aoc19.day2.process!([2,3,0,3,99]) == [2,3,0,6,99]
        @test aoc19.day2.process!([2,4,4,5,99,0]) == [2,4,4,5,99,9801]
        @test aoc19.day2.process!([1,1,1,4,99,5,6,0,99]) == [30,1,1,4,2,5,6,0,99]
        @test_throws ErrorException("invalid opcode at index 1 : 3") aoc19.day2.process_opcode!(1, [3])
        @test_throws ErrorException("invalid opcode at index 5 : 42") aoc19.day2.process!([1, 1, 1, 0, 42])
        @test part1(day = 2) == 9706670
    end

    @testset "part2" begin
        @test part2(day = 2) == 2552
    end
end

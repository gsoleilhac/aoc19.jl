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


@testset "day2" begin
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

@testset "day3" begin
    ex1 = ["R8" "U5" "L5" "D3" ; "U7" "R6" "D4" "L4"]
    ex2 = ["R75" "D30" "R83" "U83" "L12" "D49" "R71" "U7" "L72" ; "U62" "R66" "U55" "R34" "D71" "R55" "D58" "R83" ""]
    ex3 = ["R98" "U47" "R26" "D63" "R33" "U87" "L62" "D20" "R33" "U53" "R51" ; "U98" "R91" "D20" "R16" "D67" "R40" "U7" "R15" "U6" "R7" ""]
    @testset "part1" begin
        @test aoc19.day3.part1(ex1) == 6
        @test aoc19.day3.part1(ex2) == 159
        @test aoc19.day3.part1(ex3) == 135
        @test part1(day = 3) == 709
    end

    @testset "part2" begin
        @test aoc19.day3.part2(ex1) == 30
        @test aoc19.day3.part2(ex2) == 610
        @test aoc19.day3.part2(ex3) == 410
        @test part2(day = 3) == 13836
    end
end

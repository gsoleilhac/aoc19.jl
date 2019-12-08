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

@testset "day4" begin
    @testset "part1" begin
        @test part1(day = 4) == 2814
    end
    @testset "part2" begin
        @test part2(day = 4) == 1991
    end
end

@testset "day5" begin
    @testset "part1" begin
        @test part1(day = 5) == 10987514
    end

    @testset "part2" begin
        program = [3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,
        1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,
        999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99]
        @test aoc19.day5.part1(program, -1) == 999
        @test aoc19.day5.part1(program, 7) == 999
        @test aoc19.day5.part1(program, 8) == 1000
        @test aoc19.day5.part1(program, 9) == 1001
        @test part2(day = 5) == 14195011
    end
end

@testset "day6" begin
    @testset "part1" begin
        input = [["COM","B"], ["B","C"], ["C","D"], ["D","E"], ["E","F"], ["B","G"], ["G","H"], ["D","I"], ["E","J"], ["J","K"], ["K","L"]]
        @test aoc19.day6.part1(input) == 42
        @test part1(day = 6) == 245089
    end

    @testset "part2" begin
        input = [["COM","B"], ["B","C"], ["C","D"], ["D","E"], ["E","F"], ["B","G"], ["G","H"], ["D","I"], ["E","J"], ["J","K"], ["K","L"], ["K", "YOU"], ["I", "SAN"]]
        @test aoc19.day6.part2(input) == 4
        @test part2(day = 6) == 511
    end
end

@testset "day7" begin
    @testset "part1" begin
        @test aoc19.day7.part1([3,15,3,16,1002,16,10,16,1,16,15,15,4,15,99,0,0]) == 43210
        @test aoc19.day7.part1([3,23,3,24,1002,24,10,24,1002,23,-1,23,101,5,23,23,1,24,23,23,4,23,99,0,0]) == 54321
        @test aoc19.day7.part1([3,31,3,32,1002,32,10,32,1001,31,-2,31,1007,31,0,33,1002,33,7,33,1,33,31,31,1,32,31,31,4,31,99,0,0,0]) == 65210
        @test part1(day = 7) == 87138
    end

    @testset "part2" begin
        @test aoc19.day7.part2([3,26,1001,26,-4,26,3,27,1002,27,2,27,1,27,26,27,4,27,1001,28,-1,28,1005,28,6,99,0,0,5]) == 139629729
        @test aoc19.day7.part2([3,52,1001,52,-5,52,3,53,1,52,56,54,1007,54,5,55,1005,55,26,1001,54,
        -5,54,1105,1,12,1,53,54,53,1008,54,0,55,1001,55,1,55,2,53,55,53,4,
        53,1001,56,-1,56,1005,56,6,99,0,0,0,0,10]) == 18216
        @test part2(day = 7) == 17279674
    end
end


@testset "day8" begin
    @testset "part1" begin
        @test part1(day = 8) == 2125
    end

    @testset "part2" begin
        @test part2(day = 8) isa aoc19.day8.UnicodePlots.Plot
    end
end



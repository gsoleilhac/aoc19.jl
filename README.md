# aoc19

[![Build Status](https://travis-ci.com/gsoleilhac/aoc19.jl.svg?branch=master)](https://travis-ci.com/gsoleilhac/aoc19.jl)
[![Codecov](https://codecov.io/gh/gsoleilhac/aoc19.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/gsoleilhac/aoc19.jl)

### Running

```julia
julia> ]dev https://github.com/gsoleilhac/aoc19.jl
julia> using aoc19
julia> part1(day = 1)
julia> part2(day = 1)
julia> aoc19.benchmarkAll()
```

| day | part1      | part2      |
|-----|------------|------------|
| 1   | 128.731 ns | 2.189 μs   |
| 2   | 7.667 μs   | 26.200 ms  |
| 3   | 236.701 μs | 64.300 μs  |
| 4   | 60.491 ms  | 62.120 ms  |
| 5   | 26.200 μs  | 28.800 μs  |
| 6   | 1.576 ms   | 929.500 μs |
| 7   | 7.400 ms   | 15.704 ms  |
| 8   | 78.700 μs  | 12.500 μs  |
| 9   | 45.600 μs  | 28.132 ms  |
| 10  | 22.498 ms  | 26.234 ms  |
| 11  | 36.592 ms  | 1.282 ms   |
| 12  | 673.000 μs | 598.268 ms |

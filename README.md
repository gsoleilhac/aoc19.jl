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
| 1   | 119.471 ns | 1.710 μs   |
| 2   | 389.599 ns | 914.401 μs |
| 3   | 211.799 μs | 56.100 μs  |
| 4   | 42.616 ms  | 43.896 ms  |
| 5   | 15.000 μs  | 26.301 μs  |
│ 6   │ 1.320 ms   │ 802.699 μs │
│ 7   │ 2.628 ms   │ 14.782 ms  │
module day14

import ..aoc19: run_program!
using StaticArrays, Combinatorics, ProgressMeter

readInput() = [split(line, r",|[=>]", keepempty=false) for line in readlines(joinpath(@__DIR__,"input.txt"))]
struct Chemical
    type::Symbol
    qty::Int
end
Chemical(s::AbstractString) = begin 
    x = split(s, ' ', keepempty=false)
    Chemical(Symbol(x[2]), parse(Int, x[1]))
end

struct Reaction
    input::Vector{Chemical}
    output::Chemical
end
Reaction(v::Vector{<:AbstractString}) = Reaction(Chemical.(v[1:end-1]), Chemical(v[end]))

function produce!(n, chemical::Chemical, recipes::Dict{Symbol, Reaction}, products::Dict{Symbol, Int}, ore = Ref(0))
    if chemical.type == :ORE
        products[:ORE] += n
        ore[] += n
    else
        reaction = recipes[chemical.type]
        m = ceil(Int, n / reaction.output.qty)
        for c in reaction.input
            if products[c.type] < m * c.qty
                produce!(m * c.qty - products[c.type], c, recipes, products, ore)
            end
            consume!(m, c, products)
        end
        products[chemical.type] +=  m * reaction.output.qty
    end
    ore[]
end

function consume!(m, c, products)
    products[c.type] -= m * c.qty
end

function part1(data, n_fuel = 1)
    reactions = Reaction.(data)
    recipes = Dict(r.output.type => r for r in reactions)
    products = Dict(r => 0 for r in keys(recipes))
    push!(products, :ORE => 0)
    produce!(n_fuel, recipes[:FUEL].output, recipes, products)
end

function part2(data)
    max_ore = 1000000000000
    reactions = Reaction.(data)
    recipes = Dict(r.output.type => r for r in reactions)
    products = Dict(r => 0 for r in keys(recipes))
    push!(products, :ORE => 0)

    min = max = 1
    while produce!(max, recipes[:FUEL].output, recipes, copy(products)) < max_ore
        min = max
        max *= 10
    end
    
    res = searchsortedfirst(min:max, max_ore ; 
        lt = (a, b) -> produce!(a, recipes[:FUEL].output, recipes, copy(products)) < b)

    return (min:max)[res] - 1
end

end
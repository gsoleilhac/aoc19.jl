module day14

readInput() = [split(line, r",|[=>]", keepempty=false) for line in readlines(joinpath(@__DIR__,"input.txt"))]
struct Chemical
    type::Symbol
    qty::Int
end
Chemical(s::AbstractString) = split(s, ' ', keepempty=false) |> x -> Chemical(Symbol(x[2]), parse(Int, x[1]))

struct Reaction
    input::Vector{Chemical}
    output::Chemical
end
Reaction(v::Vector{<:AbstractString}) = Reaction(Chemical.(v[1:end-1]), Chemical(v[end]))

function produce!(n::Int, chemical::Chemical, recipes::Dict{Symbol, Reaction}, products::Dict{Symbol, Int}, ore = Ref(0))
    if chemical.type == :ORE
        products[:ORE] += n
        ore[] += n
    else
        reaction = recipes[chemical.type]
        m = ceil(Int, n / reaction.output.qty) # how many times we need to apply the recipe to make at least n units of chemical
        for c in reaction.input
            if products[c.type] < m * c.qty
                missing_qty = m * c.qty - products[c.type]
                produce!(missing_qty, c, recipes, products, ore)
            end
            products[c.type] -= m * c.qty #consume m times that product
        end
        products[chemical.type] +=  m * reaction.output.qty # produce m times
    end
    ore[]
end

function part1(data)
    reactions = Reaction.(data)
    recipes = Dict(r.output.type => r for r in reactions)
    products = Dict(r => 0 for r in keys(recipes))
    products[:ORE] = 0
    produce!(1, recipes[:FUEL].output, recipes, products)
end

function part2(data)
    max_ore = 1000000000000
    reactions = Reaction.(data)
    recipes = Dict(r.output.type => r for r in reactions)
    products = Dict(r => 0 for r in keys(recipes))
    products[:ORE] = 0

    min, max = 1, 10
    while produce!(max, recipes[:FUEL].output, recipes, copy(products)) < max_ore
        min, max = max, 10max
    end
    
    res = searchsortedfirst(min:max, max_ore ; 
        lt = (a, b) -> produce!(a, recipes[:FUEL].output, recipes, copy(products)) < b)

    return (min:max)[res] - 1
end

end
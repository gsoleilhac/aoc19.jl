module day6

const input = split.(readlines(joinpath(@__DIR__, "input.txt")), ')')

mutable struct Node
    name::Symbol
    parent::Union{Nothing, Node}
    children::Vector{Node}
end
Base.show(io::IO, n::Node) = print(io, n.name)

function makeTree(input)
    d = Dict{Symbol, Node}()
    for line in input
        leftSym = Symbol(first(line))
        left = get!(d, leftSym, Node(leftSym, nothing, []))
        rightSym = Symbol(last(line))
        right = get!(d, rightSym, Node(rightSym, left, []))
        right.parent = left
        push!(left.children, right)
    end
    d
end

function part1(input)
    d = makeTree(input)
    nbOrbits = 0
    for n in values(d)
        p = n
        while p.parent !== nothing
            p = p.parent
            nbOrbits += 1
        end
    end
    nbOrbits    
end

function part2(input)
    d = makeTree(input)

    YOU = d[:YOU]
    SAN = d[:SAN]

    # List all parents from "YOU" with their distance
    parentNodes = Dict{Node, Int}()
    p, i = YOU, 0
    while p.parent !== nothing
        push!(parentNodes, p.parent => i)
        p = p.parent
        i += 1
    end

    # Iterate each parent from "SAN", counting the distance, 
    # while they're not in the list of "YOU"'s parents
    p, i = SAN, 0
    while !(p.parent in keys(parentNodes))
        p = p.parent
        i += 1
    end

    return i + parentNodes[p.parent]
end

end
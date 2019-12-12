module day12

using StaticArrays, Combinatorics, ProgressMeter

readInput() = [parse.(Int, split(x, r"[^\d|-]", keepempty=false)) for x in readlines(joinpath(@__DIR__, "input.txt"))]

struct Moon
    pos::MVector{3, Int}
    vel::MVector{3, Int}
end
Moon(pos) = Moon(pos, [0,0,0])

compare(a, b) = a == b ? 0 : a < b ? +1 : -1
function applyGravity!(a::Moon, b::Moon)
    Δ = compare.(a.pos, b.pos)
    a.vel .+= Δ
    b.vel .-= Δ
end
applyVelocity!(m::Moon) = m.pos .+= m.vel
function stepUniverse!(moons::Vector{Moon})
    for (a, b) in combinations(moons, 2)
        applyGravity!(a, b)
    end
    applyVelocity!.(moons)
end

potentialEnergy(m::Moon) = sum(abs, m.pos)
kineticEnergy(m::Moon) = sum(abs, m.vel)
energy(m::Moon) = potentialEnergy(m) * kineticEnergy(m)

function part1(input, steps = 1000)
    moons = Moon.(input)
    for _ = 1:steps
        stepUniverse!(moons)
    end
    sum(energy, moons)
end

function part2(input)
    moons = Moon.(input)
    x0, y0, z0 = (Tuple((m.pos[i], m.vel[i]) for m in moons) for i = 1:3)
    cycles = [0, 0, 0]
    iter = 1
    while any(==(0), cycles)
        stepUniverse!(moons)
        x, y, z = (Tuple((m.pos[i], m.vel[i]) for m in moons) for i = 1:3)
        x == x0 && cycles[1] == 0 && (cycles[1] = iter)
        y == y0 && cycles[2] == 0 && (cycles[2] = iter)
        z == z0 && cycles[3] == 0 && (cycles[3] = iter)
        iter += 1
    end
    lcm(cycles)
end

function part2Plot(input, nbIter=100, smooth=10)
    moons = Moon.(input)
    anim = Animation()
    @showprogress for i = 1:nbIter

        x0, y0, z0 = ([m.pos[i] for m in moons] for i = 1:3)
        stepUniverse!(moons)
        x, y, z = ([m.pos[i] for m in moons] for i = 1:3)

        rx = range.(x0, x, length=smooth)
        ry = range.(y0, y, length=smooth)
        rz = range.(z0, z, length=smooth)
        for j = 1:smooth
            xx, yy, zz = (r -> r[j]).(rx), (r -> r[j]).(ry), (r -> r[j]).(rz)
            p = scatter3d(reshape(xx, 1, :), reshape(yy, 1, :), reshape(zz, 1, :), xlims=(-20,20), ylims=(-20,20), zlims=(-20,20), 
                label=["Io" "Europa" "Ganymede" "Callisto"], color= [:green :orange :black :purple])
            frame(anim, p)
        end
    end
    anim
end

end
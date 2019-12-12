module day4

readInput() = parse.(Int, split(readline(joinpath(@__DIR__, "input.txt")), '-'))

function part1(input, f = >=(2))
    cpt, digits, count_digits = 0, zeros(Int, 6), zeros(Int, 9)
    for x = first(input):last(input)
        digits!(digits, x)
        if issorted(digits, rev=true)
            fill!(count_digits, 0)
            for d in digits
                count_digits[d] += 1
            end
            any(f, count_digits) && (cpt += 1)
        end
    end
    cpt
end

part2(input) = part1(input, ==(2))

end

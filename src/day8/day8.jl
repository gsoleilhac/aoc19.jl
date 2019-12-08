module day8

using UnicodePlots

const input = [parse(Int, i) for i in readline(joinpath(@__DIR__, "input.txt"))]

function part1(input, w=25, h=6)
    layers = reshape(input, w, h, :)
    layermin = last(findmin(mapslices(x -> count(==(0), x), layers, dims=(1,2))))[3]
    count(==(1), layers[:,:,layermin]) * count(==(2), layers[:,:,layermin])
end

function part2(input, w=25, h=6)
    layers = reshape(input, w, h, :)
    img = fill(-1, w, h)
    for i = 1:w, j = 1:h
        k = 1
        while layers[i,j,k] == 2
            k += 1
        end
        img[i, j] = layers[i,j,k]
    end
    coords = findall(==(1), img)
    scatterplot([c[1] for c in coords], [h-c[2] for c in coords] ; canvas = BlockCanvas, height = h)
end

end
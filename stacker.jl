
testArray1 = [1.1 0 0;
              1.2 0 0;
              1.3 0 0]


testArray2 = [0 2.1 0;
              0 2.2 0;
              0 2.3 0]

testArray3 =  [0 0 3.1;
               0 0 3.2;
               0 0 3.3]


testArrays = reshape([testArray1 testArray2 testArray3],
                     3, 3, 3)

function stackBasedOnDensity(densityMap, pictureStack)
    # XXX We asssume that the dimensions of the two
    #     parameter arrays are actually identical,
    #     we should check that, and raise an exception
    #     if it isn't.
    local (noOfImages, ydim, xdim) = size(densityMap)
    # Find the maximal indexes
    maxindexes = Array{Int}(3,3)
    maximage = Array{Float64}(3,3)
    for y in 1:ydim, x in 1:xdim
        maxindex = findmax(densityMap[y, x,:])[2]
        maxindexes[y,x] = maxindex
        maximage[y,x] = pictureStack[y,x, maxindex]
    end
    return (maximage, maxindexes)
end

(maximage, maxindexes) = stackBasedOnDensity(testArrays, testArrays)

scorpiondensities = map(blurrimap, scorpionstack)

@time (maxscorpion, maxscorpionindexes) =
    stackBasedOnDensity(scorpiondensities, scorpionstack)

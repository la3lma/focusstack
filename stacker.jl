
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
    local (noOfImagesP, ydimP, xdimP) = size(pictureStack)
    # Find the maximal indexes
    local maxindexes = Array{Int}(ydim,xdim)
    local maximage = Array{Float64}(ydim,xdim)
    # XXX Can this be rewritten to be more inherently parallelizable?
    for y in 1:ydim, x in 1:xdim
        maxindex = findmax(densityMap[:, y, x])[2]
        maxindexes[y,x] = maxindex
        maximage[y,x] = pictureStack[maxindex, y, x]
    end
    return (maximage, maxindexes)
end

function listOf2DArraysTo3DArray(arg)
    local first = arg[1]
    local (ydim, xdim) = size(first)
    local result = Array{Float64}(length(arg), ydim, xdim)
    local i = 1
    for a in arg
        result[i,:,:] = arg[i]
        i += 1
    end
    return result
end


function stackImages(imageList)
    local grayImageList = map( x-> Gray.(x), imageList)
    local grayChannelList = map(channelview, grayImageList)
    local grayStack  = listOf2DArraysTo3DArray(grayChannelList)

    local blurryGrayList = map(blurrimap, grayChannelList)
    local blurryStack    = listOf2DArraysTo3DArray(blurryGrayList)

    # XXX Using graystack, but I would actually prefer using
    #     the original pictures
    (maxImage, maxMaps) = stackBasedOnDensity(blurryStack, grayStack)

    imshow(maxImage)
    imshow(maxImage)

    return  (maxImage, maxMaps)
end


# Unit test, very simple dataset
(testmaximage, testmaxmaps) = stackBasedOnDensity(testArrays, testArrays)

println("Mapping lena")
lenalist = (lenaimg, lenaimg)
(lenaMax, lenaMaps) = stackImages(lenalist)

# @save and @load could be useful.

## Finding the shape of this thing
# println("Shaking the monkey")
# mandrilstacklist = (mandg, mandg, mandg)
# mandrilstack = reshape([mandg mandg mandg], 3, 512, 512)
# print("blurrimapping")
# mdens = map(blurrimap, mandrilstacklist)
# mandrildensities = listOf2DArraysTo3DArray(mdens)
# print("computing maxmandril")
# (maxmandril, maxmandrilindexes) = stackBasedOnDensity(mandrildensities, mandrilstack)


# imshow(mandril)
# imshow(maxmandril)

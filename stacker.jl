# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at

#   http://www.apache.org/licenses/LICENSE-2.0

# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.


using ImageView
using Images
using FileIO
using Colors


##
##  Focus stack/blurriness estimation code.
##


"""
Determine the blurriness of a picture using the blurriness
estimator from XXX.  Returns a number between 0 and 1.
0 means very sharp, 1 means very blurry.

*examples:

     julia> foo = blurriness(channelview(imgg))
     0.0693817138671875
"""
function blurriness(image)
    # Find M and N
    local   f = fft(image)
    # local  Fc = fft(shiftOrigin(image))
    local fc = f # Just taking a chance

    # local  AF = abs(Fc) # Absolute value of centered fourier tranformof image I
    local af = abs.(fc)

    # local  Mf = max(AF) # Maximum value of frequency component in F
    local mf = maximum(af)

    # local  TH = getNoOfPixelsAboveTreshold(Mf/1000)
    local th = length(find(x-> (x > mf/1000), af))
    # local  measure = TH / (M*N)
    local (m, n) = size(image)
    local measure = th / (m * n)

    # Fm = Frequency Domain Image Blur Measure
    return measure
end


"""
Apply the blurriness to a neigbourhood around every picture around a pixel in
the image, and use that estimated blurriness, as an estimate of the blurriness
of that particular pixel. Returns as an array

*Example

   tbd
"""
function blurrimap(img)

    ## XXX This thing does not correctly traverse all of the
    ##     pixels in the correct way so the blurriness estimate
    ##     is wrong (but still usable)
    local (ydim, xdim) = size(img)
    local blocksize=5 # not all numbers works, that's bad.

    #  XXX the offset thing is not getting it right yet.
    local offset= blocksize

    local count=0
    local xlim=trunc(Int, (round(xdim/blocksize)*(blocksize - 1)))
    local ylim=trunc(Int, (round(ydim/blocksize)*(blocksize - 1)))

    local cview=channelview(img)
    local result = Array{Float64}(ydim, xdim)
    for y in 1:ylim, x in 1:xlim
        segment = cview[y:y+blocksize, x:x+blocksize]
        result[y + offset, x + offset] = blurriness(segment)
        count = count + 1
    end
    print("Number of segments in image  = $count\n")
    return result
end


"""
Based on a density map 3D array,  and a stack of pictures,
produce a focus-stacked composite picture.
"""
function stackBasedOnDensity(densityMap, pictureStack)
    local (noOfImages, ydim, xdim) = size(densityMap)
    local (noOfImagesP, ydimP, xdimP) = size(pictureStack)

    local maxindexes = Array{Int}(ydim,xdim)
    local maximage = Array{Float64}(ydim,xdim)

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

"""
Using a list of images, produce a pair consisting of
a stacked image, and an image describing which original
picture has been used to produce a particular pixel.
"""
function stackImages(imageList)
    local grayImageList = map( x-> Gray.(x), imageList)
    local grayChannelList = map(channelview, grayImageList)
    local grayStack  = listOf2DArraysTo3DArray(grayChannelList)

    # XXX I want to use proper images, but this doesn't work
    #     yet. Keeping this dead code as a challenge to myself :-)
    #    local imageStack = listOf2DArraysTo3DArray(imageList)

    local blurryGrayList = map(blurrimap, grayChannelList)
    local blurryStack    = listOf2DArraysTo3DArray(blurryGrayList)

    # Should use imageStack when grayStack is proven to work
    (maxImage, maxMaps) = stackBasedOnDensity(blurryStack, grayStack)

    imshow(maxImage)

    return  (maxImage, maxMaps)
end

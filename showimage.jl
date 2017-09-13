using ImageView
using Images
using FileIO
using Colors

# Run include("showimage.jl")

# 1. Read an image (could be replaced by one of the
# sample images)

# Test image
using TestImages
#img = load("data/scorpion-lapse/scorpion_lapse_1.png")
#img = testimage("mandrill")
img=testimage("lena")
imgg = Gray.(img)
fftimg = fft(channelview(imgg))
cimg = channelview(imgg)

zor = log.(abs.(fft(cimg)))
normfft = 255 .*(zor./maximum(zor))

#imshow(img)

# 2. Block algorithm: Make an algorithm that will pick out a block
#    centered around a pixel coordinate, do a calculation on that
#    block, and put the result into a matrix that has the size of the
#    image (could/should be interpreted as an image to evaluate
#    reasonableness).  Be able to adjust block size.

(ydim, xdim) = size(img)
blocksize=2 # not all numbers works, that's bad.
count=0
xlim=trunc(Int, (round(xdim/blocksize)*(blocksize - 1)))
ylim=trunc(Int, (round(ydim/blocksize)*(blocksize - 1)))

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
of that particular pixel.
"""
function blurrimap(img)

end


cview=channelview(imgg)
for y in 1:blocksize:ylim, x in 1:blocksize:xlim
    # Maybe use  views instead? S2 = view(A, 5, :, 2:6)
    segment = cview[y:y+blocksize, x:x+blocksize]
    blurriness(segment)
    count = count + 1
end

print("Number of segments in image  = $count\n")


# 2.1 Make a sharpness estimator (based on the paper refered to
#     elsewhere)


# 3. Sharpness stack generation: Make an algorithm that can process a
#    stack of images, and for each image, run the block algorithm and
#    generate a representation of that image, and store it alongside
#    the original.

# 4. Index picture generation: For the generated images, for each
#    pixel position, pick the index of the image that has the highest
#    value, put that value into a separate image.  This image will now
#    represent a "height matrix" into the focus-layer space.  It can
#    be interpreted as a conventional height matrix just for fun.
# 4.1 This algorithm could be extended into generating a 3D density
#     map generating algorithm, for picking out the sharp parts of the
#     images, assuming that these will outline actual features in a 3D
#     structure.

# 5. Generate a "focus stacked image" where original pixels are
#    collected, using the index picture to pick the pixel from the
#    sharpest image generating a "focused stacked" picture that
#    usually will be sharper than any of the picures being input
#    into the stacking algorithm.

typeof(img)

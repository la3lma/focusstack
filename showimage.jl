using ImageView
using Images

# 1. Read an image (could be replaced by one of the
# sample images)
img = imread("data/scorpion-lapse/scorpion_lapse_1.png")

# 2. Block algorithm: Make an algorithm that will pick out a block
#    centered around a pixel coordinate, do a calculation on that
#    block, and put the result into a matrix that has the size of the
#    image (could/should be interpreted as an image to evaluate
#    reasonableness).  Be able to adjust block size.

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

# 5. Generate a "focus stacked image" where original pixels are
#    collected, using the index picture to pick the pixel from the
#    sharpest image generating a "focused stacked" picture that
#    usually will be sharper than any of the picures being input
#    into the stacking algorithm.

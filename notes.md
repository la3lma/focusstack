## Some doodling with julia


     Pkg.add("Images")
     Pkg.add("DataFrames")
     Pkg.add("ImageView")

     using ImageView
     using Images
     using DataFrames

     I = imread ("data/scorpion-lapse/scorpion_lapse_1.png");



    baz = rgb2gray(img)
    quux =	img_gld_gs = reinterpret(Uint8,data(baz))

    zotrlogimage = convert(Image, zotrlog)

+ Trying out https://www.juliabox.org/
   seems to not solve anything not already solved, and the other way round.
http://timholy.github.io/Images.jl/
https://github.com/timholy/Images.jl


Need to concoct a set of experiments that will take me to the level where I can actually start working on something interesting.



  + https://github.com/timholy/Images.jl


+ Couldn't find a way to display images
     


+ The Cairo toolkit didn't build using brew, so I'm reinstalling a fresh julia to see how that goes.
+ Perhaps ijulia is a good way of doing this?  Perhaps even autloading of images/batches to an ijulia instance in the intertubes somewhere is the optimal solution for microscope images?  We'll find out soon enough.

## How to do focus stacking

+ https://en.wikipedia.org/wiki/Focus_stacking
+ GPL software
  + https://en.wikipedia.org/wiki/CombineZ
  + https://en.wikipedia.org/wiki/Hugin_(software)
  + http://sourceforge.net/projects/macrofusion/
  + http://rsb.info.nih.gov/ij/plugins/stack-focuser.html

+ The basic idea (as far as I can see it)
  +  Start with a list of images.
  +  For each pixel in each image, determine a "sharpness" value.  This
     value is a proxy for the number of high frequency features available
     in close (a few pixels) proximity of that pixel.  Higher values
     means more high frequency elements.
  +  To generate a sharp image, for each pixel in the resulting image,
     pick the pixel from the image that has the sharpest value for that
     particular pixel

If this naive approach works, then the subproblems to be solved 
are something like this:

  + To determine high frequency values, perform a convolusion  that
    will transform each pixel into a proxy for the frequency in its
    surrounding.  The convolution mask will have to be determined, it
    may not be  a very simple one, but essentially it is a filter
    that lets more through if it is of higher frequency, but it is
    not a strict high-pass filter.

  + The selection and generation operations can most likely be 
    formulated as a vector operation that is vectorized by 
    octave/julia  implementation.   It will still be a lot of
    data that has to be shuffled, but in principle it should only
    be a line or two of code.



# Focus Stack

This is an experiment in focus staking


It started by me not knowing very much about the subject, except that it
exists.  I do have a microscope though, and it has a nice camera (a
raspberry pi camera in a 3D mounted adapter) mounted on it, so it can take  tme series of
pictures.  If I move the focal plane up and down I will get pictures
that are sharp in some parts and blurred in others.  The idea of focus
stacking is to pick out the parts that are sharpest from all of the
pictures in the series and combine them into a picture that is sharper
than any of the original pictures.

Eventually wrote some code in Julia.   Found a blurriness estimator in
[1] and implemented that (I think, just read the paper and implemented
it as best as I could without testing that all my assumptions are correct).

Have tested the algorithm on test images from Julia's image processing
library, and on a set of microscopic pictures in a series called
"scorpion-lapse", which is a series of pictures of a "house
pseudoscorpion" (Chelifer Cancroides) that I captured in my home :)

All of the software here will be open sourced using the Apache 2
license. The image series is Apache 2 licensed (by me, I took the
pictures).



# The basic idea (as far as I can tell)
  +  Start with a list of images.
  +  For each pixel in each image, determine a "sharpness" value.  This
     value is a proxy for the number of high frequency features available
     in close (a few pixels) proximity of that pixel.  Higher values
     means more high frequency elements.
  +  To generate a sharp image, for each pixel in the resulting image,
     pick the pixel from the image that has the sharpest value for that
     particular pixel


# How I got there.

Tried octave, too hard. Tried julia, wouldn't load my images.  Waited two years, downloaded https://juliacomputing.com/ juliapro 0.6, and that just worked right out of the box.   Googled "blurriness estimation" (+ variations and permutations), found [1], implemented it.  Fiddled around to get some pictures through the pipeline  to verify that it actually does something reasonable, and now it does.


# Some possible future directions

* Better runtime efficiency.   Less copying, and also perhaps use some FFT hacks to avoid running on FFT of a neigbourhood per pixel.

* Use the blurriness mapp to make a 3D density map of the object being imaged (a bombination of thresholding and "Marching Cubes" I presume.

* Make a 3D model of the object that can be displayed in a browser with OpenGL and/or be printed by a 3D printer.


## More references on how to do focus stacking

+ https://en.wikipedia.org/wiki/Focus_stacking
+ GPL software
  + https://en.wikipedia.org/wiki/CombineZ
  + https://en.wikipedia.org/wiki/Hugin_(software)
  + http://sourceforge.net/projects/macrofusion/
  + http://rsb.info.nih.gov/ij/plugins/stack-focuser.html


[1] "Image Sharpness Measure for Blurred Images in Frequency" by
      Kanjar De and V. Masilamani.   Procedia Engineering 64 ( 2013 ) 149 – 158
     International Conference on DESIGN AND MANUFACTURING, IConDM 2013

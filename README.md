# focusstack

This is an experiment in focus stacking for microscopy.

It started by me not knowing very much about the subject, except that it
exists.  I do have a microscope though, and it has a nice camera (a
raspberry pi camera) mounted on it, so it can take time series of
pictures.  If I move the focal plane up and down I will get pictures
that are sharp in some parts and blurred in others.  The idea of focus
stacking is to pick out the parts that are sharpes from all of the
pictures in the series and combine them into a picture that is sharper
than any of the original pictures.

Eventually wrote some code in Julia.   Found a blurriness estimator in
[1] and implemented that (I think, just read the paper and implemented
it as best as I could without testing that all my assumptions are correct).

Have tested the algorithm on test images from Julia's image processing
library, and on a set of microscopic pictures in a series called
"scorpion-lapse", which is a series of pictures of a "house
pseudoscorpion" (Chelifer cancroides) that I captured in my home :)

All of the software here will be open sourced, either Apache 2 or
GPL 3. Haven't really decieded yet.  The time series is Apache 2 licensed
(by me, I took the pictures).


[1] "Image Sharpness Measure for Blurred Images in Frequency" by
      Kanjar De and V. Masilamani.   Procedia Engineering 64 ( 2013 ) 149 – 158
     International Conference on DESIGN AND MANUFACTURING, IConDM 2013

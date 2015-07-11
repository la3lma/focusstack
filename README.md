# focusstack

This is an experiment in focus stacking for microscopy.

I don't at present know very much about the subject, except that it
exists.  I do have a microscope though, and it has a nice camera (a
raspberry pi camera) mounted on it, so it can take time series of
pictures.  If I move the focal plane up and down I will get pictures
that are sharp in some parts and blurred in others.  The idea of focus
stacking is to pick out the parts that are sharpes from all of the
pictures in the series and combine them into a picture that is sharper
than any of the original pictures.

I want to see how easy it is to do this. The plan is to use octave,
python, julia, or some other tool.

For now I have just added a data set with some pictures with various
focus planes.  The series is called "scorpion-lapse" since it is a
time series of pictures of a book scorpion.


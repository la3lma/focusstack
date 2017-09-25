# Time everything, make a file that logs benchmarks
# of various kinds, and also makes plots that allows
# those plots to be examined in some useful way.
# The thing to plot is timing (possibly with variations)
# for each sha thingy, also registred with respect to
# calender date when the test was run.  Also, log what kind
# of machinery was used to run the tests (osx,linux,
# CPU stats (if known) etc.).
#
# Plan: Start out using straight (open) code for a couple of
#       benchmaks, then modify to use a macro that
#       instruments code (look at the @time macro for
#       inspiration), then make something that will be able
#       to run the tests.

# tic() toc()

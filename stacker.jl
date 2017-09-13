
testArray1 = [1.1 0 0;
              1.2 0 0;
              1.3 0 0]


testArray2 = [0 2.1 0;
              0 2.2 0;
              0 2.3 0]

testArray3 =  [0 0 3.1;
               0 0 3.2;
               0 0 3.3]


# I want to reshape this either into a 3 x 9 array, where the
# first coordinate is the array, the second is the unrolled index into the
# 2d array.  Alternatively (preferably?) a 3 x 3 x 3 matrix that
# we can then make a nice preferably vectorzed mapper for


testArrays = reshape([testArray1 testArray2 testArray3],
                     3, 3, 3)

# Find the maximal indexes
maxindexes = Array{Int}(3,3)
maximage = Array{Float64}(3,3)
for y in 1:3, x in 1:3
    maxindex = findmax(testArrays[y, x,:])[2]
    maxindexes[y,x] = maxindex
    # XXX This is cheating, since the testArrays
    #     will represent the blurriness, but what we
    #     really want is the pixel from the original
    #     set of images.  We'll get there though.
    maximage[y,x] = testArrays[y,x, maxindex]
end

# Then translate that into an image consisting only of the
# maximal values.


for y in 1:3, x in 1:3

end

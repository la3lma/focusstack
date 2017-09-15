
##
##  Ad hoc testing
##


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



# Unit test, very simple dataset
(testmaximage, testmaxmaps) = stackBasedOnDensity(testArrays, testArrays)

println("Mapping lena")
lenalist = (lenaimg, lenaimg)
(lenaMax, lenaMaps) = stackImages(lenalist)



println("Mapping mandril")
mandrillist = (mandrilimg, mandrilimg)
(maxmandril, mandrilmaps) = stackImages(mandrillist)

println("Mapping scorpion")
(maxScorpion, scorpionMaps) = stackImages(scorpionlist)


# @save and @load could be useful.

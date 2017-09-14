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


## Blur estimator pseudocoede


# Algorithm for image quality measure
# Input: Image I of size M×N.
# Output: Image Quality measure (FM) where FM stands for Frequency Domain Image Blur Measure
# Step 1: Compute F which is the Fourier Transform representation of image I
# Step 2: Find Fc which is obtained by shifting the origin of F to centre.
# Step 3: Calculate AF = abs (Fc) where AF is the absolute value of the centered Fourier transform of image I.
# Step 4: Calculate M = max (AF) where M is the maximum value of the frequency component in F.
# Step 5: Calculate TH = the total number of pixels in F whose pixel value > thres, where thres = M/1000.
# Step 6: Calculate Image Quality measure (FM) from equation (1).

#   equation 1: measure = TH / (M x N)

Function blurriness(image)
    # Find M and N
    local   F = fft(I)
    local  Fc = fft(shiftOrigin(I))
    local  AF = abs(Fc) # Absolute value of centered fourier tranformof image I
    local  Mf = max(AF) # Maximum value of frequency component in F
    local  TH = getNoOfPixelsAboveTreshold(Mf/1000)
    local  measure = TH / (M*N)
end

# The idea is then to use a window around every pixel (e.g. 16x16) and then calculate
# a value for every pixel.  This value is then used to select from which image plane
# we should get a pixel (we should always get the sharpest pixel .-)

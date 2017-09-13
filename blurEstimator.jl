

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

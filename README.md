# Digital Image Processing - Second Assignment

The assignment is a part of the course "Digital Image Processing" in the Department of Electrical & Computer Engineering of the Aristotle University of Thessaloniki. The goal of this assignment is to build our own implementations of the Hough transform, Harris Corner Detector and Image Rotation.

You can find the input image that was used at the experiments [here](https://github.com/tasos-m/DIP-Hough-Harris-Rotation/blob/main/im2.jpg). 

## Hough transform
The Hough Transform is concerned with the identification of lines in the image. Our own implementation can be found in the _myHoughTransform.m_ and the script that demonstrates the functionality of the algorithm is the _deliverable_1_.m. 
The input image is resized 20%, converted to grayscale and normalized at the range of [0,1]. We apply a Gaussian smoothing with standard deviation of 4 and a Sobel Edge Detector with threshold 0.02, in order to get the clipped image that becomes input to the Hough Transform algorithm.

The output image with the lines detected:

![1](https://user-images.githubusercontent.com/66207231/111867972-14a35600-8980-11eb-8846-1ee002c71bec.png)

## Harris Corner Detector
Harris Corner Detector is a corner detection operator that is used to extract corners and infer features of an image. Our own implementation can be found in the _myDetectHarrisFeatures.m_ and the script that demonstrates the functionality of the algorithm is the _deliverable_2_.m. 
The input image is resized 10%, converted to grayscale and normalized at the range of [0,1]. At this level of resizing, the algorithm terminated faster and gave better results.

![2](https://user-images.githubusercontent.com/66207231/111868441-88466280-8982-11eb-857b-a6b3c9613933.png)

## Image Rotation
In this part we build an anti-clockwise rotation function. Our own implementation can be found in the _myImgRotation.m_ and the script that demonstrates the functionality of the algorithm is the _deliverable_3_.m. 

>Anti-Clockwise Rotation Matrix 

|  cos(θ) | sin(θ) |
| --- | --- |
| **-sin(θ)** | **cos(θ)** |

* Rotation 54°

![3](https://user-images.githubusercontent.com/66207231/111868660-f17aa580-8983-11eb-903a-d391367b4ac9.png)

* Rotation 213°

![4](https://user-images.githubusercontent.com/66207231/111868746-5209e280-8984-11eb-882e-bbc2dac7bf75.png)

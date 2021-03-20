clear
clc
close all;
%% Load the image, downsample it and covert it to gray scale
RGB = imread('im2.jpg');
RGB = imresize(RGB,0.1);
I  = rgb2gray(RGB);
% Normalization to values [0,1]
I=double(I) / 255;

%% Call the myDetectHarrisFeatures function to detect the corners of the image
corners = myDetectHarrisFeatures(I);
figure;
imshow(I);
hold on

%% Plot the corners
for i=1:length(corners)
    % Size of the Square
    w = 5;
    h = 5;
    % Center pixel, the detected corner 
    xCenter = corners(i,1);
    yCenter = corners(i,2);
    % Begin to draw the square from this pixel
    xLeft = xCenter - 2;
    yBottom = yCenter - 2;
    rectangle('Position', [xLeft, yBottom, w, h], 'EdgeColor', 'r', 'FaceColor', 'r');
end


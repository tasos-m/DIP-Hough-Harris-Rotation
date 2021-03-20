% Mouratidis Anastasios 9040

clear
clc
close all;

%% Load the image and downsample it
RGB = imread('im2.jpg');
RGB = imresize(RGB,0.2);

%% Rotate image 54*pi/180
I1 = myImgRotation(RGB,(54*pi/180));
figure;
imshow(I1);

%% Rotate image 213*pi/180
I2 = myImgRotation(RGB,(213*pi/180));
figure;
imshow(I2);
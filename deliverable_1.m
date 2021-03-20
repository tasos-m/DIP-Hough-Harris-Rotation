clear;
close all
clc;
%% Load the image, downsample it and covert it to gray scale
RGB = imread('im2.jpg');
RGB = imresize(RGB,0.2);
I  = rgb2gray(RGB);

% Normalization to values [0,1]
I=double(I) / 255;

% Apply a Gaussian smoothing with standard deviation of 4
I=imgaussfilt(I,4);

%% Edge detection
BW = edge(I,'sobel',0.02);

% Size of the clipped image 
[N1,N2] = size(BW);
%% Hough Transform Variables

% Input variables of the hough transform function
Drho = 1;
Dtheta = pi/180;
n = 25;

% Rho and theta vectors 
rmax = round(sqrt(N1^2+N2^2));
R = -rmax : Drho : rmax;
T = -pi/2 : Dtheta : pi/2 - pi/180;

%% Call myHoughTransform function
[H,L,res] = myHoughTransform(BW, Drho, Dtheta, n);

%% Plot the H matrix and point out the values of L matrix
figure;
imshow(imadjust(rescale(H)),'XData',T,'YData',R,'InitialMagnification','fit');
title('Hough transform');
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;

for i = 1 : length(L)
 plot(L(i,2), L(i,1), 's');
end 

%% Draw the lines that Hough Transform detected
figure;
imshow(RGB);

for i= 1:n
    rho = L(i,1);
    theta = L(i,2);
    % Check if the line is vertical 
    if (sin(theta)==0)
            hold on
            x=rho/(cos(theta));
            plot(x*[1 1],ylim,'LineWidth',2,'Color','red')        
    else
            x=0:0.05:N2-1;
            y=-((cos(theta))/(sin(theta)))*x + rho/(sin(theta));
            hold on
            plot(x,y,'LineWidth',2,'Color','red')
    end
end


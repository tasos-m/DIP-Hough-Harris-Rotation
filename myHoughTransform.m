% Function of Hough Transform
function [H,L,res] = myHoughTransform(img_binary, Drho, Dtheta, n)

% Initialize the L matrix
L = zeros(n,2);

% Dimensions of the binary image
[N1,N2] = size(img_binary);

rmax = round(sqrt(N1^2+N2^2));

% Define R and t vectors
R = -rmax : Drho : rmax;
T = -pi/2 : Dtheta : pi/2 - pi/180;

% Find the edges pixels
[y,x]=find(img_binary);

% Initialize the H matrix
H = zeros(length(R),length(T));

%For all the edges and for all the given angles calculate the r and assign
%the votes in the H matrix
for i=1:length(y)
    for j=1:length(T)
        r = x(i)*cos(T(j))+y(i)*sin(T(j));
        H(floor(r)+rmax,j) = H(floor(r)+rmax,j) + 1;
    end
end

% Unique function returns a vector of all levels of H in an ascending order
A = unique(H);
% Put them in a descending order
A = flipud(A);
counter = 0;

% Find the n max values of matrix H, which are couples of (rho,theta) that
% represent lines in the image
for i= 1:n
    [r,t] = find(H==A(i));
    counter = counter + A(i);
    rho=R(r(1));
    theta=T(t(1));
    L(i,1) = rho;
    L(i,2) = theta;
end
res = N1*N2 - counter;
end


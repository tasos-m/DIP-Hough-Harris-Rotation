% Function to detect harris interest points
function corners = myDetectHarrisFeatures(I)

% Size of the given image
[N1, N2] = size(I);

% Variables
k = 0.04;
Threshold=0.01;
sigma = 1;
window = sigma * 3;

% Generate a grid in the 2-D space given the two vectors
[x,y] = meshgrid(-window:window,-window:window);

% Gaussian filters
Gxy = exp(-(x.^2+y.^2)/(2*sigma^2));

Gx = x.* exp(-(x.^2+y.^2)/(2*sigma^2));
Gy = y.* exp(-(x.^2+y.^2)/(2*sigma^2));

% Derivatives
Ix = conv2(Gx,I);
Iy = conv2(Gy,I);

Ix2 = Ix .^2;
Iy2 = Iy .^2;
Ixy = Ix .*Iy;

Sx2 = conv2(Gxy, Ix2);
Sy2 = conv2(Gxy, Iy2);
Sxy = conv2(Gxy, Ixy);

im = zeros(N1, N2);

for x=1:N1
    for y=1:N2
       M = [ Sx2(x,y) Sxy(x,y) ; Sxy(x,y) Sy2(x,y) ];
       R = det(M) - k * (trace(M)^2);
       % If R is greater than threshold, assign the R value to that pixel 
       if(R>Threshold)
           im(x,y) = R;
       end
    end
end

% Thin the corners as one pixel per corner
filtering = im > imdilate(im,[1 1 1 ; 1 0 1 ; 1 1 1 ] );

[y1,x1] = find(filtering==true);

% Shift the positions 
y1 = y1 - 2 * window;
x1 = x1 - 2 * window;

corners = [x1, y1];

end


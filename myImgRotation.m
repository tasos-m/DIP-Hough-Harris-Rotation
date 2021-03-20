% Function that rotates an image given an angle rads regardless the
% channels of it (RGB,graycale,etc)
function rotImg = myImgRotation(img, angle)

img = im2double(img);

% Find the size and the channels of the image
[height, width, chan] = size(img);

Channels = zeros(height,width,chan);
for i=1:chan
    Channels(:,:,i) = img(:,:,i);
end

% Rotation Matrix
M = [cos(angle) sin(angle) ; -sin(angle) cos(angle)];

% The 4 corners of the input image
top_left_corner = [1 1]';
top_right_corner = [width 1]';
bottom_left_corner = [1 height]';
bottom_right_corner = [width height]';

% The 4 corners of the rotated image
top_left_rot = M * top_left_corner;
top_right_rot = M * top_right_corner;
bottom_left_rot = M * bottom_left_corner;
bottom_right_rot = M * bottom_right_corner;

x_axis = [top_left_rot(1),top_right_rot(1),bottom_left_rot(1),bottom_right_rot(1)];
y_axis = [top_left_rot(2),top_right_rot(2),bottom_left_rot(2),bottom_right_rot(2)];

x_min = min(x_axis);
x_max = max(x_axis);
y_min = min(y_axis);
y_max = max(y_axis);

% Shift in x and y axis in order tohave positive coordinates 
x_shift = 1-x_min;
y_shift = 1-y_min;

% Calculate dimensions in order to fit the rotated image
width_rot = ceil(x_max) - floor(x_min);
height_rot = ceil(y_max) - floor(y_min);

% Initialize the rotated image
rotImg = zeros(height_rot,width_rot,chan);

% Initialize the new image's channels
Channels_rot = zeros(height_rot,width_rot,chan);
temp = zeros(chan,1);

% Calculate values fn the pixels of the new image using bilinear interpolation
 for y_rot = 1 : height_rot
     for x_rot = 1 : width_rot
         
        %Calculate the inverse matrix in order to rotate the new pixels back
        M_inv = [cos(-angle) sin(-angle) ; -sin(-angle) cos(-angle)];
        
        pixels_input= M_inv*[x_rot-x_shift;y_rot-y_shift];
        x_in = pixels_input(1);
        y_in = pixels_input(2);
                
        % Bilinear Interpolation
        x1 = floor(x_in);
        x2 = ceil(x_in);
        y1 = floor(y_in);
        y2 = ceil(y_in);
        
        % If (xin,yin) is inside the input image then calculate the values of 
        % the channels using bilenear interpolation else assign the value 0

        if (x1 >= 1) && (x1 <= width) && (x2 >= 1) && (x2 <= width) && (y1 >= 1) && (y1 <= height)&& (y2 >= 1) && (y2 <= height)
            for i=1:chan
                temp(i) = (Channels(y1,x1,i) + Channels(y2,x1,i) + Channels(y1,x2,i) + Channels(y2,x2,i))/4;
            end
        else
            for i=1:chan
                temp(i) = 0;
            end            
        end
        % Assign the values of the pixel in each channel
        for i=1:chan
            Channels_rot(y_rot, x_rot,i) = temp(i);
        end
    end
 end
 % Assign the channels to the final rotated image
for i=1:chan
    rotImg(:,:,i) = Channels_rot(:,:,i);
end
end
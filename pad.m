%expand the image to smooth edges. Change [a,b,c,d] into [d,c,b,a,b,c,d];
function image_ex = pad(image, width,s)
[m,n] = size(image);
if s == 0
    %mirror in second dimention. Add columns on each side.
    edge_left = image(:,1:width);
    edge_right = image(:, (n - width + 1):n);
    edge_left_flip = flip(edge_left, 2);
    edge_right_flip = flip(edge_right, 2);
    image_ex = [edge_left_flip, image, edge_right_flip]; %merge columns

    %mirror in first dimension. Add rows on each side.
    edge_up = image_ex(1:width, :);
    edge_down = image_ex((m - width + 1):m, :);
    edge_up_flip = flip(edge_up, 1);
    edge_down_flip = flip(edge_down, 1);
    image_ex = [edge_up_flip;image_ex;edge_down_flip]; %merge rows
elseif s == 1
    edge_left = zeros(size(image,1),width);
    edge_right = zeros(size(image,1), width);
    image_ex = [edge_left, image, edge_right]; %merge columns

    %mirror in first dimension. Add rows on each side.
    edge_up = zeros(width,size(image_ex,2));
    edge_down = zeros(width, size(image_ex,2));
    image_ex = [edge_up;image_ex;edge_down]; %merge rows
end

image_RGB = imread('two_balls.jpg');
% RGB_gray = rgb2gray(image_RGB);
bw_image = im2bw(image_RGB, 0.9);
bw_image_inverted = imcomplement(bw_image);

size_row = size(bw_image_inverted,1);
size_col = size(bw_image_inverted,2);
% half_image = binary_image(1:100, :);
binary_image = [];
for i = 1:size_row+1
    for j = 1:size_col+1
        if (i == 1 | j==1)
            binary_image(i,j) = 0;
        else
            binary_image(i,j) = bw_image_inverted(i-1, j-1);
        end
    end
end
labels = zeros(size_row, size_col);
give_label = [];
index_givelabel = 1;
value_givelabel = 11;
give_label(index_givelabel) = value_givelabel;
for row = 2:size_row+1
    for col = 2:size_col+1
        if (binary_image(row, col) == 1)
            if (binary_image(row-1,col) == 0 && binary_image(row,col-1) == 0)
            labels(row, col) = give_label(index_givelabel);
            index_givelabel = index_givelabel + 1;
            value_givelabel = value_givelabel + 1;
            give_label(index_givelabel) = value_givelabel;
            elseif (binary_image(row-1,col) == 1 && binary_image(row,col-1) == 0)
                labels(row, col) = labels(row-1, col);
            elseif (binary_image(row-1,col) == 0 && binary_image(row,col-1) == 1)
                labels(row, col) = labels(row, col-1);
            elseif (binary_image(row-1,col) == 1 && binary_image(row,col-1) == 1)    
                if(labels(row -1,col) == labels(row, col-1))
                    labels(row, col) = labels(row-1, col);
                else
                    labels(row, col) = labels(row-1, col);
                    labels(row, col-1) = labels(row-1, col);
                end
            end
        else
            labels(row, col) = 0;
        end
    end 
end
while 1
    count = 0;
    for i = 2:size_row
        for j = 2:size_col
            if (labels(i,j) ~= 0)
                if (labels(i-1,j) ~=0)
                    if (labels(i,j) < labels(i-1,j))
                        labels(i-1,j) = labels(i,j);
                        count = count + 1;
                    elseif (labels(i,j) > labels(i-1,j))
                        labels(i,j) = labels(i-1,j);
                        count = count + 1;
                    end                   
                end
                if (labels(i,j-1) ~= 0)
                    if (labels(i,j) < labels(i,j-1))
                        labels(i,j-1) = labels(i,j);
                        count = count + 1;
                    elseif (labels(i,j) > labels(i,j-1))
                        labels(i,j) = labels(i,j-1);
                        count = count + 1;
                    end                   
                end
            end
        end
    end
    if (count == 0)
        break;
    end
end
cmap = [0,0,0;1,0,0;0,1,0];
%remap original image to indeces 1,2,3,4
B=zeros(size(labels));
B(labels==0)=1;
B(labels==11)=2;
B(labels==13)=3;
% B(A==255)=4;
%define color image by remapping
RGB = ind2rgb(B,cmap);
%remapped image
figure;
subplot(1,2,1), imshow(bw_image_inverted);
subplot(1,2,2), imshow(RGB);


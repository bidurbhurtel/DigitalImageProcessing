poor_contrast = rgb2gray(imread('poor_contrast_.jpg'));
size_row = size(poor_contrast,1);
size_col = size(poor_contrast,2);
intensity_label = [0:255];
% for counting the number of each intensity labels
number_of_each_intensity_label = zeros(1,256);
for L = 1:256
    for i = 1:size_row
        for j = 1:size_col
            if (poor_contrast(i,j) == L-1)
                number_of_each_intensity_label(L) = number_of_each_intensity_label(L) + 1;
            end
        end
    end
end
% CDF transformation of each intensity label for histgram equalization
hist_equalized_intensity = zeros(1,256);
for k = 1:256
    for j = 1:k
        hist_equalized_intensity(k) = hist_equalized_intensity(k) + 255*number_of_each_intensity_label(j)/(size_col*size_row);
    end
    hist_equalized_intensity(k) = round(hist_equalized_intensity(k));
end
% histogram equalized image
new_image = zeros(size_row, size_col);
for L = 1:256
    new_image(poor_contrast == L-1) = hist_equalized_intensity(L);
end
number_of_each_intensity_label_new = zeros(1,256);
for L = 1:256
    for i = 1:size_row
        for j = 1:size_col
            if (new_image(i,j) == L-1)
                number_of_each_intensity_label_new(L) = number_of_each_intensity_label_new(L) + 1;
            end
        end
    end
end
% for i = 1:size_row
%     for j = 1:size_col
%         index = poor_contrast(i,j)+1;
%         new_image(i,j) = hist_equalized_intensity(index);
%     end
% end

new_image_gray = mat2gray(new_image);
subplot(2,2,1), bar(intensity_label, number_of_each_intensity_label);
title('Original Histogram');
subplot(2,2,2), imshow(poor_contrast);
title('Original Image');
subplot(2,2,3), bar(intensity_label, number_of_each_intensity_label_new);
title('Equalized Histogram');
subplot(2,2,4), imshow(new_image_gray);
title('Equalized Image');

image_balls = rgb2gray(imread('two_balls.jpg'));
image_vib = rgb2gray(imread('vib.jpg'));
%cropping images to match the sizes
image1 = image_balls(6:195,:);
image2 = image_vib(:,27:238);

%% matrix as variable
image1 = im2double(image1);
image2 = im2double(image2);

%% fft of two balls image
balls_fft = fft(image1);
mag_fft_balls = abs(balls_fft);
phase_fft_balls = angle(balls_fft);
mag_shift_balls = fftshift(mag_fft_balls);
log_transformed_balls = log(1+ abs(mag_shift_balls));
% figure, imshow(log_transformed_balls, []);

%% fft of vibrant image
vib_fft = fft(image2);
mag_fft_vib = abs(vib_fft);
phase_fft_vib = angle(vib_fft);
mag_shift_vib = fftshift(mag_fft_vib);
log_transformed_vib = log(1+ abs(mag_shift_vib));
% figure, imshow(log_transformed_vib, [])

%% inverse fft of images using their own magnitude and phase angle
ifft_balls = ifft(balls_fft);
ifft_vib = ifft(vib_fft);

%% ifft using phase angle of different image
%new image using magnitude of balls and phase of vibrant image
phase_of_vib = mag_fft_balls.*exp(1i*phase_fft_vib);
ifft_phase_vib = ifft(phase_of_vib);
%new image using magnitude of vib and phase of balls
phase_of_balls = mag_fft_vib.*exp(1i*phase_fft_balls);
ifft_phase_balls = ifft(phase_of_balls);


%% for displaying
% figure, imshow(image1), title('1st Image: Balls');
% figure, imshow(image2), title('2nd Image: Candies');
figure, imshow(log_transformed_balls, []), title('Magnitude of logged Balls');
figure, imshow(mag_shift_balls, []), title('Magnitude of shifted Balls');
figure, imshow(mag_fft_balls, []), title('Magnitude of Balls');
% figure, imshow(log_transformed_vib, []), title('Magnitude of Candies');
% figure, imshow(phase_fft_balls, []), title('Phase of Balls');
% figure, imshow(phase_fft_vib, []), title('Phase of Candies');
% figure, imshow(ifft_balls, []), title('IFT of Balls');
% figure, imshow(ifft_vib, []), title('IFT of Candies');
% figure, imshow(ifft_phase_vib, []), title('Magnitude of Balls and phase of Candies');
% figure, imshow(ifft_phase_balls, []), title('Magnitude of Candies and phase of Balls');
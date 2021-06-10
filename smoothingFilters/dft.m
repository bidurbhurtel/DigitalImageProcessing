image_balls = rgb2gray(imread('two_balls.jpg'));
image_vib = rgb2gray(imread('vib.jpg'));
%cropping images to match the sizes
image1 = image_balls(6:195,:);
image2 = image_vib(:,27:238);

%% fft of two balls image
balls_fft = fft(image1);
mag_fft_balls = abs(balls_fft);
phase_fft_balls = angle(balls_fft);

%% fft of vibrant image
vib_fft = fft(image2);
mag_fft_vib = abs(vib_fft);
phase_fft_vib = angle(vib_fft);

%% inverse fft of images using their own magnitude and phase angle
ifft_balls = ifft(balls_fft);
ifft_vib = ifft(vib_fft);

%% ifft using phase angle of different image
%new image using magnitude of balls and phase of vibrant image
phase_of_vib = mag_fft_balls.*exp(1i*phase_fft_vib);
ifft_phase_vib = ifft(phase_of_vib);




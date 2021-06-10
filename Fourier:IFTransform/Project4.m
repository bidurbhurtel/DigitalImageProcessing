%      ECE 558 - Digital Image Processing        %
%      Dr. Lalit Gupta | Fall 2016               %
%      Project 4: Combining Spectrum of Images   %
%      Ryan Spencer     11/09/2016               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Input images
img1=imread('two_balls.jpg');
img2=imread('vib.jpg');
img1 = img1(6:195,:);
img2 = img2(:,27:238);

figure; %Results Plotted
%Input Images - reference
subplot(4,2,1);
imshow(img1);
subplot(4,2,2);
imshow(img2);
%Change Images grayscale
img1G=rgb2gray(img1);
img2G=rgb2gray(img2);

%Matrix as variable
img1GV=im2double(img1G);
img2GV=im2double(img2G);
%Fourier Transform
img1FT=fftn(img1GV);
img2FT=fftn(img2GV);

%Plot Fourier Transform
subplot(4,2,3);
imshow(abs(log(1+fftshift(img1FT))),[]);
subplot(4,2,4);
imshow(abs(log(1+fftshift(img2FT))),[]);

%Components of each image
%Real part
R1=real(img1FT);
R2=real(img2FT);
%Complex part
I1=imag(img1FT);
I2=imag(img2FT);
%Phase
phase1=angle(img1FT);
phase2=angle(img2FT);
%Magnitude
mag1=(I1.^2+R1.^2).^0.5;
mag2=(I2.^2+R2.^2).^0.5;

%Combination
I12=mag1.*exp(1i.*phase2);
I21=mag2.*exp(1i.*phase1);
Ic1=exp(1i*phase2);
Ic2=exp(1i*phase1);

%Applying inverse Fourier Transform for final result 
N1=real(ifft2(I12));
N2=real(ifft2(I21));
N3=(ifft2(Ic1));
N4=(ifft2(Ic2));

%Plot 
subplot(4,2,7);
imshow(N1);
subplot(4,2,5);
imshow(N3,[]);
subplot(4,2,8);
imshow(N2);
subplot(4,2,6);
imshow(N4,[]);
close all
clc
img = double(imread('mire.pgm'));
%imgInf = imfinfo('mire.pgm');
%imgInf shows that img is 512*512 & greyscale

%matlab uses fft and not fft2

figure
imagesc(log(fftshift(abs(fft2(img)))))
colormap gray


imgSmall = img(1:2:end,1:2:end);
figure
imagesc(imgSmall)
colormap gray

imgBig = kron(imgSmall, ones(2));
figure
imagesc(imgBig)

colormap gray

figure
imagesc(log(fftshift(abs(fft2(imgBig)))))
colormap gray


% imgBigBilinear = interp2(imgSmall);
% figure
% imagesc(imgBigBilinear)
% colormap gray
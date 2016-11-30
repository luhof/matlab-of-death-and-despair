close all
clc
img = double(imread('texture.pgm'));

figure
imagesc(img)
colormap gray


dft = fft2(img);
dft = dft/sqrt(256*256);

figure
imagesc(log(fftshift(abs(dft))));
colormap gray

% both energies are the same.
energy = sum(img(:).^2)
energyDft = sum(abs(dft(:)).^2)

%transformed coeff. modulos
figure
imagesc(log10(abs(dft)))
colormap gray

%ratio between max & min of coeff module
ratio = db(max(max((abs(dft)))) / min(min(abs(dft))) )

idft = ifft2(dft);
idft = idft * sqrt(256*256);

figure
imagesc((abs(idft)))
colormap gray

%the error is very small !
err = sum((img(:) - idft(:)).^2)


lines = (0:1:255)'*ones(1,256);
cols = ones(256,1)*(0:1:255);
 

W1 = cos(pi*lines.*((2.*cols)+ 1)/(2*256));

W1 = sqrt(2/256)*W1;
W1(1,:) = W1(1,:)/sqrt(2);
W2 = W1;

g = W1*img*W2';
figure
imagesc(log10(abs(g)));
colormap gray
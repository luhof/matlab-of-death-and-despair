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

%bilinear interpolation 
bilin = zeros(512,512);
bilin(1:2:end,1:2:end) = imgSmall;
bilin(2:2:512-2, 2:2:512-2) = (bilin(1:2:512-3, 1:2:512-3) + bilin(1:2:512-3, 3:2:512) + bilin(1:2:512-3, 1:2:512-3) + bilin(3:2:512, 3:2:512))/4;
bilin(2:2:512-2, 1:2:512-3) = (bilin(1:2:512-3, 1:2:512-3) + bilin(3:2:512, 1:2:512-3))/2;
bilin(1:2:512-3, 2:2:512-2) = (bilin(1:2:512-3, 1:2:512-3) + bilin(1:2:512-3, 3:2:512))/2;
bilin(end,:) = bilin(end-1,:);
bilin(:,end) = bilin(:,end-1);

figure
imagesc(bilin)
colormap gray

errKron = mean((img(:) - imgBig(:)).^2);
errBilin = mean((img(:) - bilin(:)).^2);

S = zeros(512, 256);
[n m] = ind2sub(size(S), 1:numel(S));
n = reshape(n, 512, 256);
m = reshape(m, 512, 256);
S = sinc( (n-2*m)/2);
shannon = S * imgSmall * S.';

figure
imagesc(shannon)
colormap gray

errShannon2 = mean((img(:) - shannon2(:)).^2)

figure
imagesc(shannon2)
colormap gray

minShannon1 = min(min(shannon))
minShannon2 = min(min(shannon2))
maxShannon1 = max(max(shannon))
maxShannon2 = max(max(shannon2))


% truncate this image

shannon3 = max(min(shannon2,255),0);

figure
imagesc(shannon3)
colormap gray

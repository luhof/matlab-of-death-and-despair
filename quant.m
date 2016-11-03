%quantification
close all
clc
img = double(imread('boat.pgm'));
%imgInf = imfinfo('mire.pgm');
%imgInf shows that img is 512*512 & greyscale

figure
imagesc(img)
colormap gray

Q4 = quantFunc(img,4);

figure
imagesc(Q4)
colormap gray


Q8 = quantFunc(img,8);

figure
imagesc(Q8)
colormap gray


Q16 = quantFunc(img,16);

figure
imagesc(Q16)
colormap gray

errQ4 = mean((img(:) - Q4(:)).^2)
errQ8 = mean((img(:) - Q8(:)).^2)
errQ16 = mean((img(:) - Q16(:)).^2)

QLloyd4 = lloydFunc(img, 4);
QLloyd8 = lloydFunc(img, 8);
QLloyd16 =lloydFunc(img, 16);

errQLloyd4 = mean((img(:) - QLloyd4(:)).^2)
errQLloyd8 = mean((img(:) - QLloyd8(:)).^2)
errQLloyd16 = mean((img(:) - QLloyd16(:)).^2)

figure
imagesc(QLloyd4)
colormap gray

figure
imagesc(QLloyd8)
colormap gray

figure
imagesc(QLloyd16)
colormap gray

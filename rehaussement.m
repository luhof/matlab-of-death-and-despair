close all
clc
img = double(imread('lunef.pgm'));

figure
imagesc(img)
colormap gray

%oh noes ! this picture is blurry


highPassFilter = [-1,0,-1; 0,5,0;-1,0,-1];

betterPicture = conv2(double(img), highPassFilter, 'same');


figure
imagesc(betterPicture)
colormap gray

roundedImg = round(betterPicture);

figure
imagesc(roundedImg)
colormap gray

figure
hist(img(:))

figure
hist(roundedImg(:))

%K = round(255/(512*512)) * cumsum(hist(img(:)))

%equalizedPic = histeq(roundedImg(:));

%figure
%hist(equalizedPic(:))

K2 = zeros(512,512);

for k = min(img(:)) : max(img(:))
   
    hc = find(img(:)<=k);
    hc = length(hc);
    
    i = find(img == k);
    
    K2(i) = round((255/(512*512)) * hc);
    
end

figure
hist(K2(:))
colormap gray

figure
imagesc(K2)
colormap gray
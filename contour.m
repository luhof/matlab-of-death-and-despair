close all
clc
img = imread('matisse.pgm');

figure
imagesc(img)
colormap gray

filter = [-1/2, 0, 1/2];

%contoured = imfilter(img, filter);

contoured1 = conv2(double(img), filter, 'same');
contoured2 = conv2(double(img), filter', 'same');

figure
imagesc(contoured1)
colormap gray

figure
imagesc(contoured2)
colormap gray

gradient = sqrt((contoured1.*contoured1)+(contoured2.*contoured2));

figure
imagesc(gradient)
colormap gray

%we can see horizontal/vertical contour a little bit
size(gradient)
binaryImg = zeros(476,455);
matrixWhite = find(gradient > 28);
binaryImg(matrixWhite) = 1;

figure
imagesc(binaryImg)
colormap gray

%smoothFilter
smoothFilter = ones(3, 3) / 9;

smoothPic = conv2(double(img), smoothFilter, 'same');

%now contours again :)
smoothContoured1 = conv2(double(smoothPic), filter, 'same');
smoothContoured2 = conv2(double(smoothPic), filter', 'same');

gradient = sqrt((smoothContoured1.*smoothContoured1)+(smoothContoured2.*smoothContoured2));
smoothBinaryImg = zeros(476,455);
matrixWhite = find(gradient > 20);
smoothBinaryImg(matrixWhite) = 1;

figure
imagesc(smoothBinaryImg)
colormap gray


% KIRSCH FILTER

kirschFilter = [-3, -3, 5; -3, 0, 5; -3, -3, 5]/24;

kirschContoured1 = conv2(double(img), kirschFilter, 'same');
kirschContoured2 = conv2(double(img), kirschFilter', 'same');

gradient = sqrt((kirschContoured1.*kirschContoured1)+(kirschContoured2.*kirschContoured2));
kirschBinaryImg = zeros(476,455);
matrixWhite = find(gradient > 28);
kirschBinaryImg(matrixWhite) = 1;

figure
imagesc(kirschBinaryImg)
colormap gray

% MOST PERFORMANT : CANNY AND DERICHE 
% I did it myself
% just kidding adapted an implementation found on the internets
%http://operationpixel.free.fr/traitementniveaudegris_detection_contour.php


theta_v=getappdata(1,'theta_v')
theta_h=getappdata(1,'theta_h')
n=getappdata(1,'n')
s=getappdata(1,'s')
         
r=[cos(theta_v) -sin(theta_v);
            sin(theta_v)  cos(theta_v)];
         for i = 1 : n
             for j = 1 : n
                 u = r * [j-(n+1)/2 i-(n+1)/2]';
                 h(i,j) = (exp(-u(1)^2/(2*s^2)) / (s*sqrt(2*pi)))*(-u(2) * ((exp(-u(2)^2/(2*s^2)) / (s*sqrt(2*pi))) / s^2));
             end
         end
         frontvert= conv2(double(img),filter','same');

       
 
         r=[cos(theta_h) -sin(theta_h);
            sin(theta_h)  cos(theta_h)];
         for i = 1 : n
             for j = 1 : n
                 u = r * [j-(n+1)/2 i-(n+1)/2]';
                 h(i,j) = (exp(-u(1)^2/(2*s^2)) / (s*sqrt(2*pi)))*(-u(2) * ((exp(-u(2)^2/(2*s^2)) / (s*sqrt(2*pi))) / s^2));
             end
         end
         fronthor= conv2(double(img),filter,'same');
         % normalisation
         contr=sqrt(frontvert.*frontvert+fronthor.*fronthor);
         % Thresholding
         alfa=0.1;
         contour_max=max(max(contr));
         contour_min=min(min(contr));
         seuil=alfa*(contour_max-contour_min)+contour_min;
         seuillage=contr;
         seuillage(seuillage<seuil) = seuil;
         %Ibw=max(NVI,level.*ones(size(NVI)));
         
         
         [n,m]=size(seuillage);
         X=[-1,0,+1;-1,0,+1;-1,0,+1];
             Y=[-1,-1,-1;0,0,0;+1,+1,+1];
         
         for i=1:n-2,
             for j=1:m-2,
                 if seuillage(i+1,j+1) > seuil,
                 Z=seuillage(i:i+2,j:j+2);

                 XI=[frontvert(i+1,j+1)/contr(i+1,j+1), -frontvert(i+1,j+1)/contr(i+1,j+1)];
                 YI=[fronthor(i+1,j+1)/contr(i+1,j+1), -fronthor(i+1,j+1)/contr(i+1,j+1)];
                 
                 ZI=interp2(X,Y,Z,XI,YI);
                 
                     if seuillage(i+1,j+1) >= ZI(1) && seuillage(i+1,j+1) >= ZI(2)
                     contour_final(i,j)=contour_max;
                     else
                     contour_final(i,j)=contour_min;
                     end
                 else
                 contour_final(i,j)=contour_min;
                 end
             end
         end
         img2=contour_final;
         figure
         imagesc(img2)
         colormap gray








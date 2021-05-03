clc;clear;close all;

currentFolder = pwd;
%disp(currentFolder)
imgPath = strcat(currentFolder,'\Projet_OCR\RawImages\Lavanchy\scan3.jpg');
im = imread(imgPath);

% Get red plan
imR = im(:,:,1);
% figure(12); imshow(imR)
% Isolate markers 
SE = strel('square',20);
imE = imclose(imR,SE);
bw = imE < 100;
centroids = regionprops(bw,'centroid');
centerUp = centroids(1).Centroid;
centerDown = centroids(2).Centroid;
markers = [centerUp,centerDown];

upMarker = markers(1:2);
downMarker = markers(3:end);
alpha = atan2(downMarker(1)-upMarker(1),downMarker(2)-upMarker(2));
alphaDeg = -alpha * 180/pi;
imRot = imrotate(im,alphaDeg);

imR2 = imRot(:,:,1);
% figure(12); imshow(imR)
% Isolate markers 
SE2 = strel('square',20);
imE2 = imclose(imR2,SE2);
bw2 = imE2 < 100;
%figure; imshow(bw2)
nCentroids = regionprops(bw2,'centroid');
tempsUp = [];
tempsDown = [];
for i = 1: size(nCentroids,1)
    tempUp = nCentroids(i).Centroid - upMarker;
    tempsUp= [tempsUp;abs(tempUp)];
    tempDown = nCentroids(i).Centroid - downMarker;
    tempsDown = [tempsDown;abs(tempDown)];
end
[~,idx] = min(tempsUp);
newUpMarker = nCentroids(idx).Centroid;
[~,idx] = min(tempsDown);
newDownMarker = nCentroids(idx).Centroid;




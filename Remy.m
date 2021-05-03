clc;clear;close all;

currentFolder = pwd;
%disp(currentFolder)
imgPath = strcat(currentFolder,'\Projet_OCR\RawImages\Lavanchy\scan3.jpg');
im = imread(imgPath);
 %% Get markers and redress image

% figure; imshow(imgCrop)
[imRot] = RedressImage(im);
[markers] = findMarkers(imRot);
downMarker = markers(3:end);
upMarker = markers(1:2);
%figure; imshow(imRot)


%reduce image size (makes operations faster) :
imgCrop = imRot(round(upMarker(2)-50):round(downMarker(2)+50),:,1);
figure; imshow(imgCrop)
% imBw = imR < 100;
% imRbw = imrotate(bw,alphaDeg);
% figure; imshow(imRbw)



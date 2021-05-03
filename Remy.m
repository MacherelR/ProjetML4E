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
offset = 70;
imgCrop = imRot(round(upMarker(2)-offset):round(downMarker(2)+offset),:,1);
figure; imshow(imgCrop)






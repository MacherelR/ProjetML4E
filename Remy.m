clc;clear;close all;

currentFolder = pwd;
%disp(currentFolder)
%U-Z_Lavanchy.jpeg   scan3.jpg
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

cropMarkers = findMarkers(imgCrop);
downMarker = cropMarkers(3:end);
upMarker = cropMarkers(1:2);
% figure; imshow(imgCrop)
% axis on;
% hold on;
% plot(round(upMarker(1)),round(upMarker(2)),'r+','MarkerSize',15,'LineWidth',2);
% hold off

% Extract every case :
gray = imgCrop;
Iblob = gray > 100;

nCasesHor = 22;
nCasesVert = 5;

caseHeigth = 110;
caseWidth = 80;
offsetLine = 60;
a = round(upMarker(1))+offsetLine;
b = round(upMarker(2))- 55;
rect1 = gray(b:b+caseHeigth,a: a+caseWidth);
figure; imshow(rect1)




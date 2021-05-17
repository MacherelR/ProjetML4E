clc;clear;close all;

currentFolder = pwd;
disp(currentFolder)
%U-Z_Lavanchy.jpeg   \Projet_OCR\RawImages\Lavanchy\scan3.jpg
%\Scans\A_G.jpg    \Scans\2021_05_07-17_05_35_3.jpg
imgPath = strcat(currentFolder,'\Scans\A_H.jpg');
im = imread(imgPath);

 %% Get markers and redress image
im = rgb2gray(im);
%figure; imshow(im)
[imRot] = RedressImage(im);
[markers] = findMarkers(imRot);
downMarker = markers(3:end);
upMarker = markers(1:2);
%% reduce image size (makes operations faster) :
offset = 70;
imgCrop = imRot(round(upMarker(2)-offset):round(downMarker(2)+offset),:,1);
cropMarkers = findMarkers(imgCrop);
downMarker = cropMarkers(3:end);
upMarker = cropMarkers(1:2);
%% Extract every case :
binImg = imgCrop > 150;
nCasesHor = 22;
nCasesVert = 5;
caseHeight = 90;
caseWidth = 70;
offsetLine = 65;
offsetUp = 45;
offsetRows = 35;
aInit = round(upMarker(1))+offsetLine;
bInit = round(upMarker(2))- offsetUp;
letters = [];
b = bInit;
%% Get all Lines
for j = 1:nCasesVert
    line = GetLine(aInit,b,binImg,nCasesHor,caseHeight,caseWidth);
    b = b + caseHeight + offsetRows +20;
    letters{j} = line;
end
 
 %% Without cleaning
%  for i = 1: size(letters,2)
%    figure;
%    DisplayLine(letters{i}) 
%  end
 
 %% Generate Dataset
 j = 1;
 for i = 14:22
     txt = sprintf('B_%d.jpg',j);
     imwrite(letters{1}{i},txt);
     j = j+1;
 end







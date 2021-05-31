clc; clear; close all;
%% First implementation
%% Get folder path and open images
currentFolder = pwd;
%disp(currentFolder)
%U-Z_Lavanchy.jpeg   \Projet_OCR\RawImages\Lavanchy\scan3.jpg
%\Scans\A_G.jpg    \Scans\2021_05_07-17_05_35_3.jpg '\DoNotShareThat\A1.jpg
imgPath = strcat(currentFolder,'\DoNotShareThat\A1.jpg');
im = imread(imgPath);
%% Rotate and get markers 
im = rgb2gray(im);
%figure; imshow(im)
%imwrite(im,'GrayScale.jpg')
% pause;
[imRot] = RedressImage(im);
%figure; imshow(imRot)
[markers] = findMarkers(imRot);
downMarker = markers(3:end);
upMarker = markers(1:2);
%% Extract cases
binImg = imRot > 200;
[cases,isEmpty] = getCases(binImg,upMarker(1),upMarker(2),true);



%% Trash

%Example with labels :

idx = find(labelsArray == 'B');
Bimages = Images(idx); % Returns every cell (image) that is labelled with 'B'. Note : every images is a 5x22 cell array containing each character sample
Bdatas = [];
% Gets a Matrix with every column corresponding to a sample
for i= 1: length(Bimages)
   temp = reshape(Bimages{i},[110 1]);
   for j = 1:length(temp)
       Bdatas = [Bdatas, temp{j}(:)];
   end
end
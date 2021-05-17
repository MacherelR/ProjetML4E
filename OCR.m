clc; clear; close all;
%% First implementation
%% Get folder path and open images
% currentFolder = pwd;
% %disp(currentFolder)
% %U-Z_Lavanchy.jpeg   \Projet_OCR\RawImages\Lavanchy\scan3.jpg
% %\Scans\A_G.jpg    \Scans\2021_05_07-17_05_35_3.jpg
% imgPath = strcat(currentFolder,'\Projet_OCR\Training\B.jpg');
% im = imread(imgPath);
% %% Rotate and get markers 
% im = rgb2gray(im);
% %figure; imshow(im)
% [imRot] = RedressImage(im);
% [markers] = findMarkers(imRot);
% downMarker = markers(3:end);
% upMarker = markers(1:2);
% %% Extract cases
% binImg = imRot > 200;
% [cases,isEmpty] = getCases(binImg,upMarker(1),upMarker(2),true);

%% Useful Variables 
showDisplays = false;
nLetters = 26;
%% Reading all images in folder for training (Preprocessing)
fNameTraining = 'trainingDatas.mat';
ex = exist(fNameTraining,'file');
if ex == 2
    load 'trainingDatas.mat';
    Images = trainingDatas{1};
    labels = char(trainingDatas{2}); % Transform into characters array
else
    [Images,~,labels] = readImages('\Projet_OCR\Training',false);
    saveTrainingDatas(Images,labels);
end

%% Display Letters example
if showDisplays == true
    DisplayImage(Images{1})
end

%% encoding labels -> Each row of labelsEnc correspond to the code to the label
%Create column vector 
%labs = char(labels);
labs = categorical(labels)
categories(labs)
labelsEnc = onehotencode(labs,1)

%% Character size = 91x69




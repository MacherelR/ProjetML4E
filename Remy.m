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
imwrite(imgCrop,'Cropped.png');
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

nCasesHor = 22;
nCasesVert = 5;

caseHeight = 110;
caseWidth = 83;
offsetLine = 60;
offsetRows = 35;
aInit = round(upMarker(1))+offsetLine;
bInit = round(upMarker(2))- 55;
%rect1 = gray(b:b+caseHeight,a: a+caseWidth);
% figure; imshow(gray)
%figure; imshow(rect1)
lettersLine = [];
letters = [];
b = bInit;
line = GetLine(aInit,b,gray,nCasesHor,caseHeight,caseWidth);


% Get all Lines
for j = 1:nCasesVert
    line = GetLine(aInit,b,gray,nCasesHor,caseHeight,caseWidth);
    %txt = sprintf('i = %d | a = %d | b = %d',i,a,b)
    disp(b)
    b = b + caseHeight + offsetRows;
    letters{j} = line;
end

%% Remove blanks
cleanLine = [];
 for i = 1: nCasesVert
    newL = eraseBlanks(letters{i});
    cleanLine{i} = newL;
 end
 
 for i = 1: nCasesVert
    figure;
    DisplayLine(cleanLine{i})
 end






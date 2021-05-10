clc;clear;close all;

currentFolder = pwd;
disp(currentFolder)
%U-Z_Lavanchy.jpeg   \Projet_OCR\RawImages\Lavanchy\scan3.jpg
%\Scans\2021_05_07-17_05_35.jpg    \Scans\2021_05_07-17_05_35_3.jpg
imgPath = strcat(currentFolder,'\Scans\2021_05_07-17_05_36_2.jpg');
im = imread(imgPath);

 %% Get markers and redress image

% figure; imshow(imgCrop)
[imRot] = RedressImage(im);
[markers] = findMarkers(imRot);
downMarker = markers(3:end);
upMarker = markers(1:2);
%figure; imshow(imRot)


%% reduce image size (makes operations faster) :
offset = 70;
imgCrop = imRot(round(upMarker(2)-offset):round(downMarker(2)+offset),:,1);
%imwrite(imgCrop,'Cropped.png');
cropMarkers = findMarkers(imgCrop);
downMarker = cropMarkers(3:end);
upMarker = cropMarkers(1:2);


%% Extract every case :
binImg = imgCrop > 150;

nCasesHor = 22;
nCasesVert = 5;
caseHeight = 110;
caseWidth = 83;
offsetLine = 60;
offsetRows = 35;
aInit = round(upMarker(1))+offsetLine;
bInit = round(upMarker(2))- 55;
letters = [];
b = bInit;

%% Get all Lines
for j = 1:nCasesVert
    line = GetLine(aInit,b,binImg,nCasesHor,caseHeight,caseWidth);
    %txt = sprintf('i = %d | a = %d | b = %d',i,a,b)
    %disp(b)
    b = b + caseHeight + offsetRows;
    letters{j} = line;
end

%% Remove blanks
%  cleanLine = [];
%  for i = 1: nCasesVert
%     newL = eraseBlanks(letters{i});
%     cleanLine{i} = newL;
%  end
%  % Get only lines with text
%  idxFull = find(~cellfun(@isempty,cleanLine));
%  cleanLines = cleanLine(idxFull);
 
 %% Without cleaning
 for i = 1: size(letters,2)
   figure;
   DisplayLine(letters{i}) 
end
 %% Display every letter found line by line
%  for i = 1: size(cleanLines,2)
%     figure;
%     DisplayLine(cleanLines{i}) 
%  end





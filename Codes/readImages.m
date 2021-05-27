function [casesImg,lettersPos,labels] = readImages(folderPath,training)
% Get all files in specified folder
    disp('Image preprocessing !');
    filesDir = strcat(pwd,folderPath);
    jpgFiles = dir(fullfile(filesDir,'*.jpg'));
    jpegFiles = dir(fullfile(filesDir,'*.jpeg'));
    pngFiles = dir(fullfile(filesDir,'*.png'));
    allFiles = vertcat(jpgFiles,jpegFiles,pngFiles);
    casesImg = [];
    lettersPos = [];
    labels = [];
    currentFolder = pwd;
    for k = 1:length(allFiles)
        baseFileName = allFiles(k).name;
        fullFileName = fullfile(folderPath, baseFileName);
        fprintf('Now reading %s\n\n', baseFileName)
        % Read image 
        imgPath = strcat(currentFolder,fullFileName);
        img = imread(imgPath);
        % Rotation + markers position
        imgGray = rgb2gray(img);
%         if baseFileName == 'D.jpg' 
%             imshow(imgGray)
%             disp('Breakpoint');
%         end
        [imRot] = RedressImage(imgGray);
        [markers] = findMarkers(imRot);
%         if baseFileName == 'D.jpg' 
%             disp('Breakpoint');
%         end
        downMarker = markers(3:end);
        upMarker = markers(1:2);
        % Extract cases
        imgBin = imRot > 200;
        [cases,isEmpty] = getCases(imgBin,upMarker(1),upMarker(2),training);
        casesImg{k} = cases;
        %DisplayImage(cases);
        % As training images are all fully filled, passing empty
        % verification
        if training == false
            lettersPos{k} = isEmpty;
        end
        labels{k} = baseFileName(1);
    end
    % Alert user
    disp('End of image preprocessing !');
end


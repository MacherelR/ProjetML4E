function [ImagesDL,LabelsDL] = openDLimages(fPath)
    filesDir = strcat(pwd,fPath);
    jpegFiles = dir(fullfile(filesDir,'*.jpeg'));
    casesImg = [];
    lettersPos = [];
    labels = [];
    currentF = pwd;
    datas = [];
    OutMat = [];
    for k = 1:length(jpegFiles)
        baseFname = jpegFiles(k).name;
        fullFname = fullfile(fPath,baseFname);
        fprintf('Now reading %s\n\n', baseFileName)
        % Read image
        imgPath = strcat(currentFolder,fullFileName);
        img = imread(imgPath);
        % Rotation + markers position
        imgGray = rgb2gray(img);
        
        [imRot] = RedressImage(imgGray);
        [markers] = findMarkers(imRot);
        
        downMarker = markers(3:end);
        upMarker = markers(1:2);
        
        T = graythresh(imRot);
        imgBin = imbinarize(imRot,T);
        %imgBin = imRot > T;
        [cases,~] = getCases(imgBin,upMarker(1),upMarker(2),true);
        casesImg{k} = cases;
        %DisplayImage(cases);
        % As training images are all fully filled, passing empty
        % verification
        ex = eye(26);
        cases = reshapeCellArray(cases);
        if baseFname == 'A-j_Lavanchy.jpeg'
            for i = 1:110
                datas = [datas, cases{i}(:)];
                if i >=1 && i<12 % A
                    OutMat = [OutMat, ex(:,1)];
                elseif i >= 12 && i<= 22 % B
                    OutMat = [OutMat, ex(:,2)];
                elseif i >= 23 && i <34 % C
                    OutMat = [OutMat, ex(:,3)];
                elseif i >=34 && i <= 44 % D
                    OutMat = [OutMat, ex(:,4)];
                elseif i>44 && i< 56 % E
                    OutMat = [OutMat, ex(:,5)];
                elseif i>=56 && i<= 66 %F
                    OutMat = [OutMat, ex(:,6)];
                elseif i > 66 && i < 78 % G
                    OutMat = [OutMat, ex(:,7)];
                elseif i >= 78 && i<= 88 % H
                    OutMat = [OutMat, ex(:,8)];
                elseif i > 88 && i < 100
                    OutMat = [OutMat, ex(:,9)];
                elseif i >= 100 && i <= 110 
                    OutMat = [OutMat, ex(:,10)];
                end
                
            end
        elseif baseFname == 'K-T_Lavanchy.jpeg'
            for i = 1:110
                
            end
        end
    end
end


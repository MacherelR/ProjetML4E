function [ImagesDL,LabelsDL,OutMatDL] = openDLimages(fPath)
    currentFolder = pwd;
    filesDir = strcat(pwd,fPath);
    jpegFiles = dir(fullfile(filesDir,'*.jpeg'));
    casesImg = [];
    lettersPos = [];
    labels = [];
    currentF = pwd;
    datas = [];
    OutMat = [];
    y = [];
    for k = 1:length(jpegFiles)
        baseFname = jpegFiles(k).name;
        fullFname = fullfile(fPath,baseFname);
        fprintf('Now reading %s\n\n', baseFname)
        % Read image
        imgPath = strcat(currentFolder,fullFname);
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
        ex2 = 1:26;
        cases = reshapeCellArray(cases);
        if baseFname == 'A-J_Lavanchy.jpeg'
            %fprintf('\n Datas size : %d \n',size(datas,2))
            for i = 1:110
                datas = [datas, cases{i}(:)];
                if i >=1 && i<12 % A
                    OutMat = [OutMat, ex(:,1)];
                    y = [y,ex2(1)];
                elseif i >= 12 && i<= 22 % B
                    OutMat = [OutMat, ex(:,2)];
                    y = [y,ex2(2)];
                elseif i >= 23 && i <34 % C
                    OutMat = [OutMat, ex(:,3)];
                    y = [y,ex2(3)];
                elseif i >=34 && i <= 44 % D
                    OutMat = [OutMat, ex(:,4)];
                    y = [y,ex2(4)];
                elseif i>44 && i< 56 % E
                    OutMat = [OutMat, ex(:,5)];
                    y = [y,ex2(5)];
                elseif i>=56 && i<= 66 %F
                    OutMat = [OutMat, ex(:,6)];
                    y = [y,ex2(6)];
                elseif i > 66 && i < 78 % G
                    OutMat = [OutMat, ex(:,7)];
                    y = [y,ex2(7)];
                elseif i >= 78 && i<= 88 % H
                    OutMat = [OutMat, ex(:,8)];
                    y = [y,ex2(8)];
                elseif i > 88 && i < 100 % I
                    OutMat = [OutMat, ex(:,9)];
                    y = [y,ex2(9)];
                elseif i >= 100 && i <= 110 % J
                    OutMat = [OutMat, ex(:,10)];
                    y = [y,ex2(10)];
                end
            end
        elseif baseFname == 'K-T_Lavanchy.jpeg'
            %fprintf('Datas size : %d',size(datas,2))
            for i = 1:110
                datas = [datas, cases{i}(:)];
                if i >= 1 && i < 12 %K
                    OutMat = [OutMat,ex(:,11)];
                    y = [y,ex2(11)];
                elseif i >=12 && i<=22 %L
                    OutMat = [OutMat, ex(:,12)];
                    y = [y,ex2(12)];
                elseif i >= 23 && i <34 % M
                    OutMat = [OutMat, ex(:,13)];
                    y = [y,ex2(13)];
                elseif i >=34 && i <= 44 % N
                    OutMat = [OutMat, ex(:,14)];
                    y = [y,ex2(14)];
                elseif i>44 && i< 56 % O
                    OutMat = [OutMat, ex(:,15)];
                    y = [y,ex2(15)];
                elseif i>=56 && i<= 66 %P
                    OutMat = [OutMat, ex(:,16)];
                    y = [y,ex2(16)];
                elseif i > 66 && i < 78 % Q
                    OutMat = [OutMat, ex(:,17)];
                    y = [y,ex2(17)];
                elseif i >= 78 && i<= 88 % R
                    OutMat = [OutMat, ex(:,18)];
                    y = [y,ex2(18)];
                elseif i > 88 && i < 100 % S
                    OutMat = [OutMat, ex(:,19)];
                    y = [y,ex2(19)];
                elseif i >= 100 && i <= 110 % T
                    OutMat = [OutMat, ex(:,20)];
                    y = [y,ex2(20)];
                end
            end
        elseif baseFname == 'U-Z_Lavanchy.jpeg'
            %fprintf('Datas size : %d',size(datas,2))
            for i = 1:66
               datas = [datas,cases{i}(:)];
               if i >= 1 && i < 12 %U
                    OutMat = [OutMat,ex(:,21)];
                    y = [y,ex2(21)];
                elseif i >=12 && i<=22 %V
                    OutMat = [OutMat, ex(:,22)];
                    y = [y,ex2(22)];
                elseif i >= 23 && i <34 % W
                    OutMat = [OutMat, ex(:,23)];
                    y = [y,ex2(23)];
                elseif i >=34 && i <= 44 % X
                    OutMat = [OutMat, ex(:,24)];
                    y = [y,ex2(24)];
                elseif i>44 && i< 56 % Y
                    OutMat = [OutMat, ex(:,25)];
                    y = [y,ex2(25)];
                elseif i>=56 && i<= 66 %Z
                    OutMat = [OutMat, ex(:,26)];
                    y = [y,ex2(26)];
               end
            end
        end
    end
    LabelsDL = y;
    ImagesDL = datas;
    OutMatDL = OutMat;
end


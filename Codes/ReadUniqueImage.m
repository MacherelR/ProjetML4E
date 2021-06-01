function [casesImg,lettersPos] = ReadUniqueImage(imgPath)
    disp('Image preprocessing !');
    fileDir = strcat(pwd,imgPath);
    casesImg = [];
    lettersPos = [];
    img = imread(fileDir);
    % Rotation + markers position
    imgGray = rgb2gray(img);
    [imRot] = RedressImage(imgGray);
    [markers] = findMarkers(imRot);
    downMarker = markers(3:end);
    upMarker = markers(1:2);
    imshow(imRot);
    axis on;
    hold on;
    plot(upMarker(1),upMarker(2),'r+','MarkerSize',30,'LineWidth',2);
    % Extract cases
    T = graythresh(imRot);
    imgBin = imbinarize(imRot,T);
    [cases,isEmpty] = getCases(imgBin,upMarker(1),upMarker(2),false);
    casesImg = cases;
    lettersPos = isEmpty;
end


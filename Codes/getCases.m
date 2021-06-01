function [cases,isEmpty] = getCases(binImg,markerX,markerY,training)
%% Function used to extract cases from the original image
    %% General variables
    nLines = 5;
    nBoxes = 22;
    nVertOffset = 143; % Vertical offset between boxes
    nHorOffset = 83; %Horizontal offset between boxes
    caseHeight = 90;
    caseWidth = 68;
    minBlackPixels = 150; %Minimum of black pixels to detect if a letter is present or not
    offsetLine = 65;
    offsetUp = 45;
    nPixels = caseHeight * caseWidth;
    cases = [];
    isEmpty = [];
    for i = 1:nLines
       for j = 1:nBoxes
           yTop = (round(markerY) - offsetUp) + (i-1)*nVertOffset;
           yBottom = yTop + caseHeight;
           xLeft = round(markerX) + offsetLine + (j-1)*nHorOffset;
           xRight = xLeft + caseWidth;
           imCase = binImg(yTop:yBottom,xLeft:xRight);
           SE = strel('square',3);
           imCase = imerode(imCase,SE);
           imCase = imcrop(imCase,[7,8,52,74]);
           imCase = imresize(imCase,0.5);
           cases{i,j} = imCase;
           %disp(sum(~imCase(:)))
           if training == false
               empty = (sum(~imCase(:))) < minBlackPixels;
               isEmpty{i,j} = empty;
           end
       end
    end
    
end


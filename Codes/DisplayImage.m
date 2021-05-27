function [] = DisplayImage(Image)
    nLines = 5;
    nBoxes = 22;
    ImgArray = [];
    figure;
    for i = 1:nLines
       for j = 1:nBoxes
          ImgArray = [ImgArray, Image{i,j}];
       end
    end
    montage(ImgArray);
end


function [markers] = findMarkers(im)
% Get red plan
imR = im(:,:,1);
%figure(12); imshow(imR)
% Isolate markers 
SE = strel('square',20);
imE = imclose(imR,SE);
%figure; imshow(imE)
bw = imE < 100;
%figure; imshow(bw)
centroids = regionprops(bw,'centroid');
if centroids(1).Centroid(2) > centroids(2).Centroid(2)
    centerUp = centroids(2).Centroid;
    centerDown = centroids(1).Centroid;
else
    centerUp = centroids(1).Centroid;
    centerDown = centroids(2).Centroid;
end

markers = [centerUp,centerDown];
end


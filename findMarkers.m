function [markers] = findMarkers(im)
% Get red plan
imR = im(:,:,1);
% figure(12); imshow(imR)
% Isolate markers 
SE = strel('square',20);
imE = imclose(imR,SE);
bw = imE < 100;
figure; imshow(bw)
centroids = regionprops(bw,'centroid');
centerUp = centroids(1).Centroid;
centerDown = centroids(2).Centroid;
markers = [centerUp,centerDown];
end


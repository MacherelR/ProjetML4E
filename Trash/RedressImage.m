function [imRot] = RedressImage(im)
%%%%%%%%%%%%%%%%%%%%%% Description %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function used to redress image that is printed with angle
markers = findMarkers(im);
upMarker = markers(1:2);
downMarker = markers(3:end);
alpha = atan((downMarker(1)-upMarker(1))/(downMarker(2)-upMarker(2)));
alphaDeg = -rad2deg(alpha);
imRot = imrotate(im,alphaDeg);
% replace black background with white
%Create image with white filling after rotation
Mask = 255 - imrotate(255*ones(size(im)),alphaDeg);
imRot(Mask == 255)= 255;
imshow(imRot)
disp('break')
end


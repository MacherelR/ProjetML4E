function [imRot] = RedressImage(im)
%%%%%%%%%%%%%%%%%%%%%% Description %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function used to redress image that is printed with angle
markers = findMarkers(im);
upMarker = markers(1:2);
downMarker = markers(3:end);
alpha = atan2(downMarker(1)-upMarker(1),downMarker(2)-upMarker(2));
alphaDeg = -rad2deg(alpha);
imRot = imrotate(im,alphaDeg);
back = 255 - imrotate(255*uint8(ones(size(im))),alphaDeg);
imRot(back == 255)= 255;
% Mrot = ~imrotate(true(size(im)),alphaDeg);
% imRot(Mrot&~imclearborder(Mrot)) = 255;
end


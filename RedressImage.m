function [imRot] = RedressImage(im)
%%%%%%%%%%%%%%%%%%%%%% Description %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function used to redress image that is printed with angle
markers = findMarkers(im);
upMarker = markers(1:2);
downMarker = markers(3:end);
alpha = atan2(downMarker(1)-upMarker(1),downMarker(2)-upMarker(2));
alphaDeg = -alpha * 180/pi;
imRot = imrotate(im,alphaDeg);
Mrot = ~imrotate(true(size(im)),alphaDeg);
imRot(Mrot&~imclearborder(Mrot)) = 255;
end


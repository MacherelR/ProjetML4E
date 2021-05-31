%% With nnstart
% if exist('NN_OCR.mat','file') == 2
%     load NN_OCR.mat;
%     NN_OCR = NewNN;
% else
%     ex = eye(26);
%     Inputs = X';
%     Outputs = Y;
%     nnstart
% end

% %% Saving NN
% if exist('NN_OCR.mat','file') ~= 2
%     NewNN = NN_OCR;
%     save NN_OCR.mat NewNN
% end
% %% Try on other image 
% labelArray = ['A', 'B', 'C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'];
% close all;
% i = randi(length(y));
% ysimTraining = NN_OCR(X(i,:)');
% [~,class] = max(ysimTraining);
% imshow(reshape(X(i,:),91,69))
% fprintf('\nTrue class: %d  |  Predicted class: %d | Probability of match: %.1f%% \n',y(i),class,100*ysimTraining(class));
% %disp(labelArray(y(i)))
% %% Checker la verification vide/lettre --> Erreur
% %% TODO: Tester le NN sur cette image! Reshape 1,110 ne marche pas ! Ordre perturbé !
% % Positions est juste en 5x22 mais du coup faux après
% fileName = '\Lavanchy\scan2.jpg';
% [ImagesDL,positions] = ReadUniqueImage(fileName);
% %datasDL = formDataArray(ImagesDL,labelsArrayDL);
% % Unroll images
% ImgLine = reshape(ImagesDL',110,1);
% positionsLine = cell2mat(reshape(positions',110,1));
% indexes = find(positionsLine == 0);
% 
% ImgUnrolled = unRollImages(ImgLine);
% ImgUnrolled = ImgUnrolled';
% for j =1 : size(ImgUnrolled,1)
%    %disp(j)
%    if ismember(j,indexes)
%        ysimTraining = NN_OCR(ImgUnrolled(j,:)');
%        [~,class] = max(ysimTraining);
%        figure;
%        imshow(reshape(ImgUnrolled(j,:),91,69));
%        fprintf('\n Predicted class: %s\n',labelArray(class));
%    end
% end



%     close all;
%     imshow(reshape(X(i,:),dimX,dimY))
% %     disp(i)
% %     disp(ysim(i))
%     fprintf('\nTrue class: %d  |  Predicted class: %d | True Letter : %c | Predicted : %c \n',y(i),ysim(i),labelArray(y(i)),labelArray(ysim(i)));
%     disp(labelArray(y(i)))
% for i=1:numLabels
%    predL = ysimTraining(a:(a+109));
%    yL = y(a:(a+109));
%    str = "\nTraining set accuracy for letter ";
%    newStr = strcat(str,string(labelArray(i)));
%    newStr = strcat(newStr, sprintf(' ->  %.3f',mean(double(predL == yL) * 100,'all')));
%    fprintf(newStr);
%    a = a+110;
%    disp(a)
% end

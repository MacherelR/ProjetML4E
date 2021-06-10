%% Creating neural network (cf ex4)
% in = input('Do you want to retrain the neural network ? y or n ? ','s');
% if in == 'n'
%     if exist('nnParams.mat','file') == 2 
%         load 'nnParams.mat'
%         [Theta1,Theta2] = getThetas(nnParams,inputLayerSize,hiddenLayerSize,numLabels);
%     else
%         msgbox('No file named nnParams found !');
%     end
% elseif in == 'y'
%     initial_Theta1 = randInitializeWeights(inputLayerSize, hiddenLayerSize);
%     initial_Theta2 = randInitializeWeights(hiddenLayerSize, numLabels);
%     % Unroll parameters
%     initialParams = [initial_Theta1(:) ; initial_Theta2(:)];
%     
%     m = size(X,1); % Training examples
%     [trainInd,valInd,~] = dividerand(size(XShuffle,1),0.7,0.3,0);
%     options = optimset('MaxIter',nIter); 
%     Xtrain = XShuffle(trainInd,:);
%     Ytrain = YShuffle(trainInd);
%     Xval = XShuffle(valInd,:);
%     Yval = YShuffle(valInd);
%     global yValid ; yValid = Yval;
%     global xValid ; xValid = Xval;
%     global errValidation; errValidation = [];
%     costFunction = @(p) nnCostFunction(p,inputLayerSize,hiddenLayerSize,numLabels,Xtrain,Ytrain,lambda);
%     [nnParams,fX,i] = fmincg(costFunction,initialParams,options);
%     [Theta1,Theta2] = getThetas(nnParams,inputLayerSize,hiddenLayerSize,numLabels);
%     ysimTraining = predict(Theta1,Theta2,Xtrain);
%     ysimVal = predict(Theta1,Theta2,Xval);
%     fprintf('\n Training accuracy : %.3f',mean(double(ysimTraining == Ytrain'))*100);
%     fprintf('\n Validation accuracy : %.3f',mean(double(ysimVal == Yval'))*100);
%     plot(1:i,fX);
%     title('Error training');
%     save nnParams.mat nnParams;
% end
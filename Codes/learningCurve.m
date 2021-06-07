function [errTrain,errValidation,finalParams] = learningCurve(X,y,Xval,yVal,lambda)
    m = size(X,1); % Training examples
    global inputLayerSize;
    global hiddenLayerSize;
    global numLabels;
    errTrain = zeros(m,1);
    errValidation = zeros(m,1);
%     inputLayerSize = 1290;%size(XShuffle,2); % Input layer (size of a letter)
%     hiddenLayerSize = 300; % Check how to define size
%     numLabels = 26; % From A to Z 
    for i = 10:10:m
       fprintf('I = %d',i)
       Xtest = X(1:i,:);
       ytest = y(1:i);
       [nnParams] = trainNN(X(1:i,:),y(1:i),lambda);
       errTrain(i) = nnCostFunction(nnParams,inputLayerSize,hiddenLayerSize,numLabels,X(1:i,:),y(1:i),lambda);
       errValidation(i) = nnCostFunction(nnParams,inputLayerSize,hiddenLayerSize,numLabels,Xval,yVal,lambda);
    end
    finalParams = nnParams;
end


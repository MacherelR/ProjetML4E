function [nnParams] = trainNN(X,y,lambda)
    inputLayerSize = 1290;%size(XShuffle,2); % Input layer (size of a letter)
    hiddenLayerSize = 300; % Check how to define size
    numLabels = 26; % From A to Z 
    initial_Theta1 = randInitializeWeights(inputLayerSize, hiddenLayerSize);
    initial_Theta2 = randInitializeWeights(hiddenLayerSize, numLabels);
    % Unroll parameters
    initialParams = [initial_Theta1(:) ; initial_Theta2(:)];
    costFunction = @(p) nnCostFunction(p,inputLayerSize,hiddenLayerSize,numLabels,X,y,lambda);
    options = optimset('MaxIter',50,'GradObj','on');
    
    [nnParams,~] = fmincg(costFunction,initialParams,options);
    %[Theta1,Theta2] = getThetas(nnParams,inputLayerSize,hiddenLayerSize,numLabels);
end


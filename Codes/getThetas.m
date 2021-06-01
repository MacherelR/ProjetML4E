function [Theta1,Theta2] = getThetas(nnParams,inputLayerSize,hiddenLayerSize,numLabels)
    Theta1 = reshape(nnParams(1:hiddenLayerSize * (inputLayerSize + 1)), hiddenLayerSize, (inputLayerSize + 1));
    Theta2 = reshape(nnParams((1 + (hiddenLayerSize * (inputLayerSize + 1))):end), numLabels, (hiddenLayerSize + 1));
end


clc; 
clear; close all;
%% Useful Variables 
showDisplays = false;
nLetters = 26;

%% Reading all images in folder for training (Preprocessing)
fNameTraining = 'trainingDatasStruct.mat';
ex = exist(fNameTraining,'file');
if ex == 2
    load 'trainingDatas.mat';
    Images = trainingDatas{1};
    labels = trainingDatas{2}; 
    labelsArray = cell2mat(labels);
    load 'trainingDatasStruct.mat';
    datas = DataSave.Datas;
    y = DataSave.Outputs;
    OutMat = DataSave.OutMat;
else
    [Images,~,labels] = readImages('\TrainingImages',false);
    saveTrainingDatas(Images,labels);
    labelsArray = cell2mat(labels);
    [datas,y,OutMat] = formDataArray(Images,labelsArray);
    %save trainingDatasArray.mat datas
    DataSave = struct('Datas',datas,'Outputs',y,'OutMat',OutMat);
    save trainingDatasStruct.mat DataSave
end

%% Display Letters example
if showDisplays == true
    DisplayImage(Images{1})
end
%% SHUFFLE
% r2 = randi(10,1000,1);

X = datas'; % Input
Y = y; % Output vector (or matrix) containing labels
idxPermutation = randperm(size(X,1));
XShuffle = X(idxPermutation,:);
YShuffle = Y(idxPermutation);
OutMatShuffle = OutMat(:,idxPermutation)'; 
inputLayerSize = size(XShuffle,2); % Input layer (size of a letter)
hiddenLayerSize = 400; % Check how to define size
numLabels = 26; % From A to Z 
%% Creating neural network (cf ex4)

if exist('nnParams.mat','file') == 2
    load 'nnParams.mat'
else
    initial_Theta1 = randInitializeWeights(inputLayerSize, hiddenLayerSize);
    initial_Theta2 = randInitializeWeights(hiddenLayerSize, numLabels);
    % Unroll parameters
    initialParams = [initial_Theta1(:) ; initial_Theta2(:)];
    lambda = 0.3; % Regularization parameter
    [trainInd,valInd,~] = dividerand(size(XShuffle,1),0.7,0.3,0);
    options = optimset('MaxIter',100); 
    Xtrain = XShuffle(trainInd,:);
    Ytrain = YShuffle(trainInd);
    Xval = XShuffle(valInd,:);
    Yval = YShuffle(valInd);
    costFunction = @(p) nnCostFunction(p,inputLayerSize,hiddenLayerSize,numLabels,Xtrain,Ytrain,lambda);
    [nnParams,~] = fmincg(costFunction,initialParams,options);
    save nnParams.mat nnParams;
end
%% Test model
% Obtain Theta1 and Theta2 back from nn_params
Theta1 = reshape(nnParams(1:hiddenLayerSize * (inputLayerSize + 1)), hiddenLayerSize, (inputLayerSize + 1));
Theta2 = reshape(nnParams((1 + (hiddenLayerSize * (inputLayerSize + 1))):end), numLabels, (hiddenLayerSize + 1));
dimX = 75; dimY = 53;
%pred = predict(Theta1, Theta2, X);
a = 1;
i = randi(length(y));
labelArray = ['A', 'B', 'C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'];
ysimTraining = predict(Theta1,Theta2,Xtrain);
ysimVal = predict(Theta1,Theta2,Xval);
fprintf('\n Training accuracy : %.3f',mean(double(ysimTraining == Ytrain'))*100);
fprintf('\n Validation accuracy : %.3f',mean(double(ysimVal == Yval'))*100);


%% Test model
fileName = '\Lavanchy\scan2.jpg';
[ImagesDL,positions] = ReadUniqueImage(fileName);
%datasDL = formDataArray(ImagesDL,labelsArrayDL);
% Unroll images
ImgLine = reshape(ImagesDL',110,1);
positionsLine = cell2mat(reshape(positions',110,1));
indexes = find(positionsLine == 0);

ImgUnrolled = unRollImages(ImgLine);
ImgUnrolled = ImgUnrolled';
ImgTest = ImgUnrolled(indexes,:);
ysimTest = predict(Theta1,Theta2,ImgTest);
strOut = "";
for i=1:length(ysimTest)
   %disp(labelArray(ysimTest(i))); 
   strOut = strcat(strOut,labelArray(ysimTest(i)));
end
disp(strOut)


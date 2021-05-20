clc; 
clear; close all;
%% Useful Variables 
showDisplays = false;
nLetters = 26;
%% Reading all images in folder for training (Preprocessing)
fNameTraining = 'trainingDatas.mat';
ex = exist(fNameTraining,'file');
if ex == 2
    load 'trainingDatas.mat';
    Images = trainingDatas{1};
    labels = trainingDatas{2}; 
    labelsArray = cell2mat(labels);
    load 'trainingDatasStruct.mat';
    datas = DataSave.Datas;
    y = DataSave.Outputs;
else
    [Images,~,labels] = readImages('\TrainingImages',false);
    saveTrainingDatas(Images,labels);
    labelsArray = cell2mat(labels);
    [datas,y,OutMat] = formDataArray(Images,labelsArray);
    %save trainingDatasArray.mat datas
    DataSave = struct('Datas',datas,'Outputs',y);
    save trainingDatasStruct.mat DataSave
end

%% Display Letters example
if showDisplays == true
    DisplayImage(Images{1})
end
%% SHUFFLE
% r2 = randi(10,1000,1);

%% Creating neural network (cf ex4)
inputLayerSize = 91*69; % Input layer (size of a letter)
hiddenLayerSize = 50; % Check how to define size
numLabels = 26; % From A to Z 
X = datas'; % Input
Y = y; % Output vector (or matrix) containing labels
if exist('nnParams.mat','file') == 2
    load 'nnParams.mat'
else
    initial_Theta1 = randInitializeWeights(inputLayerSize, hiddenLayerSize);
    initial_Theta2 = randInitializeWeights(hiddenLayerSize, numLabels);
    % Unroll parameters
    initialParams = [initial_Theta1(:) ; initial_Theta2(:)];
    lambda = 0.3; % Regularization parameter
    options = optimset('MaxIter',100); 
    costFunction = @(p) nnCostFunction(p,inputLayerSize,hiddenLayerSize,numLabels,X,Y,lambda);
    [nnParams,~] = fmincg(costFunction,initialParams,options);
    save nnParams.mat nnParams;
end
%% Test model
% % Obtain Theta1 and Theta2 back from nn_params
% Theta1 = reshape(nnParams(1:hiddenLayerSize * (inputLayerSize + 1)), hiddenLayerSize, (inputLayerSize + 1));
% Theta2 = reshape(nnParams((1 + (hiddenLayerSize * (inputLayerSize + 1))):end), numLabels, (hiddenLayerSize + 1));
%  
% pred = predict(Theta1, Theta2, X);
% a = 1;
% labelArray = ['A', 'B', 'C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'];
% for i=1:numLabels
%    predL = pred(a:(a+109));
%    yL = y(a:(a+109));
%    str = "\nTraining set accuracy for letter ";
%    newStr = strcat(str,string(labelArray(i)));
%    newStr = strcat(newStr, sprintf(' ->  %.3f',mean(double(predL == yL) * 100,'all')));
%    fprintf(newStr);
%    a = a+110;
%    disp(a)
% end
% % predA = pred(1:110);
% % yA = y(1:110)';
% % fprintf('\nTraining Set Accuracy: %f\n', mean(double(predA == yA) * 100);
%% Implement
if exist('NN_OCR.mat','file') == 2
    load NN_OCR.mat;
    NN_OCR = NewNN;
else
    ex = eye(26);
    Inputs = X';
    nnstart
    i = randi(length(y));
    ysim = NN_OCR(X(i,:)');
    [~,class] = max(ysim);
    imshow(reshape(X(i,:),91,69))
    fprintf('\nTrue class: %d  |  Predicted class: %d | Probability of match: %.1f%% \n',y(i),class,100*ysim(class));
    disp(labelArray(y(i)))
    NewNN = NN_OCR;
    save NN_OCR.mat NewNN
end

%% Try on other image 
%% Checker la verification vide/lettre --> Erreur
%% TODO: Tester le NN sur cette image!
fileName = '\Lavanchy\scan2.jpg';
[ImagesDL,positions] = ReadUniqueImage(fileName);
%datasDL = formDataArray(ImagesDL,labelsArrayDL);
% Unroll images
ImgLine = reshape(ImagesDL,110,1);
positionsLine = cell2mat(reshape(positions,110,1));
indexes = find(positionsLine == 1);

clc; 
clear; close all;
%% Useful Variables 
showDisplays = false;
nLetters = 26;

%% Reading all images in folder for training (Preprocessing)
fNameTraining = 'trainingDatasStruct.mat';
ex = exist(fNameTraining,'file');
in = input('Do you want to reload all images ? y or n ? ','s');

if in == 'n'
    load 'trainingDatas.mat';
    Images = trainingDatas{1};
    labels = trainingDatas{2}; 
    labelsArray = cell2mat(labels);
    load 'trainingDatasStruct.mat';
    datas = DataSave.Datas;
    y = DataSave.Outputs;
    OutMat = DataSave.OutMat;
else
    [Images,~,labels] = readImages('\TrainingImages',true);
    saveTrainingDatas(Images,labels);
    labelsArray = cell2mat(labels);
    [datas,y,OutMat] = formDataArray(Images,labelsArray);
    [DatasDL,yDL,OutMatDL] = openDLimages('\Lavanchy');
    datas = [datas,DatasDL];
    OutMat = [OutMat,OutMatDL];
    y = [y,yDL];
    %save trainingDatasArray.mat datas
    DataSave = struct('Datas',datas,'Outputs',y,'OutMat',OutMat);
    save trainingDatasStruct.mat DataSave
end


%% SHUFFLE (Not used since models automatically shuffles datas)
X = datas'; % Input
Y = y; % Output vector (or matrix) containing labels
idxPermutation = randperm(size(X,1));
XShuffle = X;%X(idxPermutation,:);
YShuffle = Y;%Y(idxPermutation);
%% GLobal Variables
global inputLayerSize; inputLayerSize = size(XShuffle,2); % Input layer (size of a letter)
global hiddenLayerSize; hiddenLayerSize = 300; % Check how to define size
global numLabels; numLabels = 26; % From A to Z 
labelArray = ['A', 'B', 'C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'];
nIter = 200;
lambda = 0.3; % Regularization parameter
Xnet = XShuffle';
Ynet = OutMat;
%% AVEC NET 
% network dans NN.mat et tr dans tr.mat
fNameTraining = 'NN.mat.mat';
ex = exist(fNameTraining,'file');
in = input('Do you want to retrain Model ? y or n ? ','s');
if in == 'y'
    trainFcn = 'trainscg'; % Gradient descent
    net = patternnet(hiddenLayerSize, trainFcn); % Create the net variable
    net.layers{1}.transferFcn = 'logsig'; % Change default transfer function to match ex3/4 implementation
    net.performParam.regularization = lambda;%tanh(lambda);  
    net.performFcn = 'mse'; % Mean squared error
    net.trainParam.epochs = nIter;
    net.trainParam.showWindow = true; % Don't show training GUI
    net.divideParam.trainRatio = 60/100;
    net.divideParam.valRatio = 20/100;
    net.divideParam.testRatio = 20/100;
    [net,tr] = train(net,Xnet,Ynet);
    plotperform(tr)
else
    load tr.mat;
    load NN.mat;
    plotperform(tr);
end
%% Accuracies
trainInd = round(tr.trainInd);
valInd = round(tr.valInd);
testInd = round(tr.testInd);
trainSet = Xnet(:,trainInd);
testSet = Xnet(:,testInd);
valSet = Xnet(:,valInd);
yTrain = net(trainSet);
[~,yTrain] = max(yTrain);
yStrain = YShuffle(trainInd);
yTest = net(testSet);
[~,yTest] = max(yTest);
yStest = YShuffle(testInd);
yVal = net(valSet);
[~,yVal] = max(yVal);
ySval = YShuffle(valInd);
fprintf('\n Training accuracy : %.3f',mean(double(yStrain == yTrain))*100);
fprintf('\n Validation accuracy : %.3f',mean(double(ySval == yVal))*100);
fprintf('\n Test accuracy : %.3f',mean(double(yStest == yTest))*100);

%plotregression(yStrain,yTrain,'Train',ySval,yVal,'validation',yStest,yTest,'Test')

%% SVM
fNameTraining = 'NN.mat.mat';
ex = exist(fNameTraining,'file');
in = input('Do you want to retrain SVM Model ? y or n ? ','s');
if in == 'y'
    Xsvm = Xnet';
    Ysvm = Y';
    datasSvm = [Xsvm , Ysvm]; %% For classification App
    disp('Now run classification Learner App, and use datasSvm as input');
else
    load trainedModelSVM.mat;
end


 % Other test, not working           
% t = templateSVM('Standardize',true,'KernelFunction','gaussian');
% Mdl = fitcecoc(Xsvm,Ysvm,'Learners',t);
% CVMdl = crossval(Mdl);
% genError = kfoldLoss(CVMdl);
% fprintf('Error : %f',genError)

%% Test model
fileName = '\Lavanchy\A-J_Lavanchy.jpeg'; %'\Lavanchy\scan2.jpg'
[ImagesDL,positions] = ReadUniqueImage(fileName);

% Unroll images
ImgLine = reshape(ImagesDL',110,1);
positionsLine = cell2mat(reshape(positions',110,1));
indexes = find(positionsLine == 0);

ImgUnrolled = unRollImages(ImgLine);
ImgUnrolled = ImgUnrolled';
ImgTest = ImgUnrolled(indexes,:);
ySoluce = [4; 1; 22; 9; 4; 12; 1; 22; 1; 14; 3; 8; 25]; % DAVID LAVANCHY
%disp(labelArray(ySoluce))
y = net(ImgTest');
ySVM = trainedModel.predictFcn(ImgTest);
[~,yL] = max(y);
disp('NN predictions : ');
disp(labelArray(yL))
disp('SVM predictions : ');
disp(labelArray(ySVM))
% fprintf('Pourcentage réussite NN : %f',mean(double(ySoluce == yL'))*100)
% fprintf('Pourcentage réussite SVM : %f',mean(double(ySoluce == ySVM))*100)


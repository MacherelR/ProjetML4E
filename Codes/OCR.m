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


%% SHUFFLE
% r2 = randi(10,1000,1);

X = datas'; % Input
Y = y; % Output vector (or matrix) containing labels
idxPermutation = randperm(size(X,1));
XShuffle = X;%X(idxPermutation,:);
YShuffle = Y;%Y(idxPermutation);
%OutMatShuffle = OutMat(:,idxPermutation)'; 
%% GLobal Variables
global inputLayerSize; inputLayerSize = size(XShuffle,2); % Input layer (size of a letter)
global hiddenLayerSize; hiddenLayerSize = 300; % Check how to define size
global numLabels; numLabels = 26; % From A to Z 
nIter = 300;
lambda = 0.3; % Regularization parameter
Xnet = XShuffle';
Ynet = OutMat;
%% AVEC NET 

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


%% Test model
dimX = 75; dimY = 53;
rDimX = round(0.5*dimX); rDimY = round(0.5);
%pred = predict(Theta1, Theta2, X);
a = 1;
labelArray = ['A', 'B', 'C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'];

%% SVM
kernelScale = 1;
boxconstraint = 1;
Xsvm = Xnet';
Ysvm = Y';
datasSvm = [Xsvm , Ysvm];
%datasSvm = uint8(datasSvm);
%gaussianSVM = fitcecoc(Xsvm,Ysvm)
                 
%% Test model
fileName = '\Lavanchy\scan1.jpg';
[ImagesDL,positions] = ReadUniqueImage(fileName);
%datasDL = formDataArray(ImagesDL,labelsArrayDL);
% Unroll images

ImgLine = reshape(ImagesDL',110,1);
positionsLine = cell2mat(reshape(positions',110,1));
indexes = find(positionsLine == 0);

ImgUnrolled = unRollImages(ImgLine);
ImgUnrolled = ImgUnrolled';
ImgTest = ImgUnrolled(indexes,:);
%ysimTest = predict(Theta1,Theta2,ImgTest);
ySoluce = [4; 1; 22; 9; 4; 12; 1; 22; 1; 14; 3; 8; 25]; % DAVID LAVANCHY
y = net(ImgTest');
ySVM = predict(gaussianSVM,ImgTest)
[~,yL] = max(y);

disp(labelArray(yL))
disp(labelArray(ySVM))
fprintf('Pourcentage réussite NN : %f',mean(double(ySoluce == yL'))*100)
fprintf('Pourcentage réussite SVM : %f',mean(double(ySoluce == ySVM))*100)


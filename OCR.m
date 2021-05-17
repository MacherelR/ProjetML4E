clc; clear; close all;
%% First implementation
%% Get folder path and open images
% currentFolder = pwd;
% %disp(currentFolder)
% %U-Z_Lavanchy.jpeg   \Projet_OCR\RawImages\Lavanchy\scan3.jpg
% %\Scans\A_G.jpg    \Scans\2021_05_07-17_05_35_3.jpg
% imgPath = strcat(currentFolder,'\Projet_OCR\Training\B.jpg');
% im = imread(imgPath);
% %% Rotate and get markers 
% im = rgb2gray(im);
% %figure; imshow(im)
% [imRot] = RedressImage(im);
% [markers] = findMarkers(imRot);
% downMarker = markers(3:end);
% upMarker = markers(1:2);
% %% Extract cases
% binImg = imRot > 200;
% [cases,isEmpty] = getCases(binImg,upMarker(1),upMarker(2),true);

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
else
    [Images,~,labels] = readImages('\Projet_OCR\Training',false);
    saveTrainingDatas(Images,labels);
end

%% Display Letters example
if showDisplays == true
    DisplayImage(Images{1})
end

%% encoding labels -> Each row of labelsEnc correspond to the code to the label
%Create column vector 
%labs = char(labels);
% labs = categorical(labels)
% categories(labs)
% labelsEnc = onehotencode(labs,1)
% sample size = 91x69
% cell2mat(Images{1}) -> Gives 455x1518 (91*5 x 69*22) matrix
% test = reshape(Images{1}, [1 110]) -> Gives 1x110 cell array containing
% every sample (character)
% test1 = reshape(cell2mat(test1), [], numel(test1)); -> Line used to
% unroll 1x110 cell array into 6279x110 matrix (each column corresponds to
% a sample

% Example with labels :
labelsArray = cell2mat(labels);
% idx = find(labelsArray == 'B');
% Bimages = Images(idx); % Returns every cell (image) that is labelled with 'B'. Note : every images is a 5x22 cell array containing each character sample
% Bdatas = [];
% % Gets a Matrix with every column corresponding to a sample
% for i= 1: length(Bimages)
%    temp = reshape(Bimages{i},[110 1]);
%    for j = 1:length(temp)
%        Bdatas = [Bdatas, temp{j}(:)];
%    end
% end

labelArray = ['A', 'B', 'C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'];
datas = [];
ex = eye(26);
y = [];
for k = 1:length(labelArray)
    idx = find(labelsArray == labelArray(k));
    if ~isempty(idx)
        pImages = Images(idx); 
        for i = 1:length(pImages)
           temp = reshape(pImages{i}, [110 1]);
           for j = 1:length(temp)
              datas = [datas, temp{j}(:)]; 
              y = [y, ex(:,k)];
           end
        end
    end
end

%% SHUFFLE
% r2 = randi(10,1000,1);

%% Creating neural network (cf ex4)
inputLayerSize = 91*69; % Input layer (size of a letter)
hiddenLayerSize = 50; % Check how to define size
numLabels = 26; % From A to Z 
initial_Theta1 = randInitializeWeights(inputLayerSize, hiddenLayerSize);
initial_Theta2 = randInitializeWeights(hiddenLayerSize, numLabels);
EncodedTable = eye(26); % create matrix where every column corresponds to a letter
% Unroll parameters
initialParams = [initial_Theta1(:) ; initial_Theta2(:)];
X = []; % Input
y = []; % Output vector (or matrix) containing labels
lambda = 0; % Regularization parameter
options = optimset('MaxIter',50); 
costFunction = @(p) nnCostFunction(p,inputLayerSize,hiddenLayerSize,numLabels,X,y,lambda);
[nnParams,~] = fmincg(costFunction,initialParams,options);


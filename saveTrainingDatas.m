function [] = saveTrainingDatas(Images,labels)
    trainingDatas{1} = Images;
    trainingDatas{2} = labels;
    save trainingDatas.mat trainingDatas
end


function [dataArray,outputArray,OutMat] = formDataArray(Images,labelsArray)
    labelArray = ['A', 'B', 'C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'];
    datas = [];
    %ex = eye(26);
    ex2 = eye(26);
    ex = 1:26;
    y = [];
    y2 = [];
    for k = 1:length(labelArray)
        idx = find(labelsArray == labelArray(k));
        if ~isempty(idx)
            pImages = Images(idx); 
            for i = 1:length(pImages)
               temp = reshape(pImages{i}, [110 1]);
               for j = 1:length(temp)
                  datas = [datas, temp{j}(:)]; 
                  y = [y, ex(k)];
                  y2 = [y2,ex2(:,k)];
               end
            end
        end
    end
    dataArray = datas;
    outputArray = y;
    OutMat = y2;
end


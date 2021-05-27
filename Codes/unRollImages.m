function [datas] = unRollImages(Images)
    N = length(Images);
    datas = [];
    for i = 1:N
       datas = [datas,Images{i}(:)]; 
    end
end


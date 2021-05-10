function [line] = GetLine(aInit,b,gray,n,caseHeight,caseWidth)
    line = [];
    a = aInit;
    for i = 1 : n
        rect = gray(b:(b+caseHeight), a:(a+caseWidth));
        SE = strel('square',5);
        rect = imerode(rect,SE);
        SE = strel('square',3);
        rect = imdilate(rect,SE);
        SE = strel('square',3);
        rect = imerode(rect,SE);
        a = a+caseWidth+13;
        %txt = sprintf('i = %d | a = %d | b = %d',i,a,b)
        line{i} = rect;
    end
end


function [newLine] = eraseBlanks(line)
    n = size(line,2);
    blankIdx = [];
    for i = 1:n
        letter = line{i};
        nDark = sum(~letter(:));
        if nDark < 200
            blankIdx = [blankIdx,i];
        end
    end
    line(blankIdx) = [];
    newLine = line;
end
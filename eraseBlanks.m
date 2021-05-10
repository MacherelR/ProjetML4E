function [newLine] = eraseBlanks(line)
    n = size(line,2);
    for i = 1 : n
        letter = line{i};
        bin = letter > 100;
        nDark = sum(~bin(:));
        if nDark < 50
            line{i} = [];
        end
    end
    newLine = line;
end


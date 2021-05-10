function [] = DisplayLine(line)
    n = size(line,2);
    for k = 1:n
        ax = subplot(2,11,k);
        imshow(line{k})
    end
end


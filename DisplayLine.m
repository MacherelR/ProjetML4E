function [] = DisplayLine(line)
    n = size(line,2);
    % Affichage
    if n > 10
        x = 2;
        y = round(n/2);
    else
        x = 1;
        y = n;
    end
    for k = 1:n
        ax = subplot(x,y,k);
        imshow(line{k})
    end
end


function [H] = update_H(sd, E, H, dt)

    for k = 1 : 3
        c = mod(k + [0, 1], 3) + 1;

        shift{1} = [0 0 0];
        shift{1}(c(2)) = -1;

        shift{2} = [0 0 0];
        shift{2}(c(1)) = -1;

        H{k} =  H{k} - dt * ...
                ((circshift(E{c(2)}, shift{2}) - E{c(2)}) ./ sd{c(1)} - ...
                ((circshift(E{c(1)}, shift{1}) - E{c(1)}) ./ sd{c(2)}));
    end

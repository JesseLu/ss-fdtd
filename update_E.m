function [E] = update_E(sp, eps, E, H, dt, a, J)

    for k = 1 : 3
        c = mod(k + [0, 1], 3) + 1;

        shift{1} = [0 0 0];
        shift{1}(c(2)) = 1;

        shift{2} = [0 0 0];
        shift{2}(c(1)) = 1;

        E{k} =  E{k} + a * J{k} + (dt ./ eps{k}) .* ...
                ((H{c(2)} - circshift(H{c(2)}, shift{2})) ./ sp{c(1)} - ...
                ((H{c(1)} - circshift(H{c(1)}, shift{1})) ./ sp{c(2)}));
    end

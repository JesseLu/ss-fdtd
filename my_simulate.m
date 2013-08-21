function [] = my_simulate(grid, eps, mu, J)

    dx = min(real([grid.s_prim{1}(:); grid.s_prim{2}(:); grid.s_prim{3}(:); ...
                 grid.s_dual{1}(:); grid.s_dual{2}(:); grid.s_dual{3}(:)]));
    dt = dx / sqrt(3) * 0.99;
    t = 0 : dt : 1e4;
    
    % Time-dependence of current excitation.
    omega = real(grid.omega);
    sigma = .1 * 2*pi/omega;
    a = exp(1i*grid.omega*t - 1*((t-3*sigma)./sigma).^2);
    plot([imag(a(:)), real(a(:))], '.-');
    pause

    [sp{1}, sp{2}, sp{3}] = ...
                    ndgrid(grid.s_prim{1}, grid.s_prim{2}, grid.s_prim{3});
    [sd{1}, sd{2}, sd{3}] = ...
                    ndgrid(grid.s_dual{1}, grid.s_dual{2}, grid.s_dual{3});

    for k = 1 : 3
        sp{k} = conj(sp{k});
        sd{k} = conj(sd{k});
    end

    E = {zeros(grid.shape), zeros(grid.shape), zeros(grid.shape)};
    H = {zeros(grid.shape), zeros(grid.shape), zeros(grid.shape)};

    for k = 1 : length(t)
        E = update_E(sp, eps, E, H, dt, a(k), J);
        H = update_H(sd, E, H, dt);
        % plot([real(E{2}(:)), imag(E{2}(:))], '.-');
        plot([real(E{2}(:)), imag(E{2}(:)), real(H{3}(:)), imag(H{3}(:))], '.-');
        pause(0.1);
    end


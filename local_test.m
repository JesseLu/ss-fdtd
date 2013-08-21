%% local_test
% Test the algorithm steady-state FDTD algorithm in Matlab.

function local_test()

    dx = 40;
    [grid, eps, mu, J] = maxwell_grid(2*pi/1550, -2e3:dx:2e3, 0, 0);
    [x, y, z] = maxwell_pos2ind(grid, 'Ey', [0 0 0]);
    J{2}(x, y, z) = 1;

    my_simulate(grid, eps, mu, J);



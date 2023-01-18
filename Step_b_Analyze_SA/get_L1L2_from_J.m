function [L1,L2] = get_L1L2_from_J(J_11,J_12,J_22)
% function [L1,L2] = get_L1L2_from_J(J_11,J_12,J_22)
%
%   Computes eigenvalues of the 2D diffusion tensor.

J_12 = J_12 / sqrt(2);

L1 = 1/2 * (J_11 + J_22 + sqrt( (J_11 - J_22).^2 + 4 * J_12.^2));
L2 = 1/2 * (J_11 + J_22 - sqrt( (J_11 - J_22).^2 + 4 * J_12.^2));

end
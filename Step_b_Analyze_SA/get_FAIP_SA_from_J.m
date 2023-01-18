function FAIP_SA = get_FAIP_SA_from_J(J_11,J_12,J_22)
% function FAIP_IA = get_FAIP_SA_from_J(J_11,J_12,J_22)
%
%  Computes fractional anisotropy or structure anistropy from diagonal element
%  of the diffusion tensor and image anisotropy
%  (according to Budde et al. 2012, NeuroImage.
%
% Written by Filip Szczepankiewicz (filip.szczepankiewicz@med.lu.se)

%J are spatial derivatives, L are eigenvalues.
[L1,L2] = get_L1L2_from_J(J_11,J_12,J_22);

M       = (L1 + L2) / 2;
FAIP_SA    = (L1 - L2) ./ (2 * M); %FAIP or SA - generated in the same way

end
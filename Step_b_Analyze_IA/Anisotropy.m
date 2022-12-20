%Create IA maps
clear

for sample = 1:16
    sample
    data_path = fullfile('..','data',num2str(sample));
    
    load(fullfile(data_path,'coreg_fine','ver1','HE.mat'),'HE');
    load(fullfile(data_path,'coreg_fine','ver1','MR.mat'),'MR');
    
%     HE = HE(1:10:end,1:10:end,:);

    [H.J_11,H.J_12,H.J_22] = get_J_from_histo(HE,1);
    H.IA = get_FAIP_IA_from_J(H.J_11,H.J_12,H.J_22);
    [H.dIA,H.dJ_11,H.dJ_12,H.dJ_22] = downsample_IA2dAIA(H.J_11,H.J_12,H.J_22,MR.FA2D,H.IA);
    H.sdIA = smooth_FA_IA(H.dIA,0.2);
    
    save(fullfile(data_path,'anisotropy','ver1','IA.mat'), 'H','MR','-v7.3');
    
end

%Create SA maps
clear

for sample = 2:2
    sample
    data_path = fullfile('..','..','data',num2str(sample));
    
    load(fullfile(data_path,'coreg_fine','ver1','HE.mat'),'HE');
    load(fullfile(data_path,'coreg_fine','ver1','MR.mat'),'MR');
    
    disp('Images loaded, calculating')
    [H.J_11,H.J_12,H.J_22] = get_J_from_histo(HE,1);
    H.SA = get_FAIP_SA_from_J(H.J_11,H.J_12,H.J_22);
    [H.dSA,H.dJ_11,H.dJ_12,H.dJ_22] = downsample_SA_to_dSA(H.J_11,H.J_12,H.J_22,size(MR.FAIP),size(H.SA));
    
    disp('Saving')
    save(fullfile(data_path,'structure_anisotropy','ver1','SA.mat'), 'H','MR','-v7.3');
    
end

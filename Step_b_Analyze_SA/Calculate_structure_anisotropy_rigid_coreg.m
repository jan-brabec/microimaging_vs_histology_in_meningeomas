%Create SA maps to improve the fine coregistration step
clear

samples = [6, 10, 16];

for sample = 1:16
    
    if sum(sample==samples)==0
        continue
    end
    
    sample
    i_HE_data_path = fullfile('..','..','data',num2str(sample),'coreg_rigid','ver1');
    o_HE_data_path = fullfile('..','..','data',num2str(sample),'coreg_fine','ver1');

    load(fullfile(i_HE_data_path,'HE.mat'),'HE');
    
    disp('Images loaded, calculating')
    [J_11,J_12,J_22] = get_J_from_histo(HE,1);
    SA = get_FAIP_SA_from_J(J_11,J_12,J_22);
    
    disp('Saving')
    save(fullfile(o_HE_data_path,'aniso2coreg.mat'), 'SA','-v7.3');
    
end

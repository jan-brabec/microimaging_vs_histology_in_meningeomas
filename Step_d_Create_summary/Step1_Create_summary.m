clear; clc;

i_data_pth = fullfile('..','..','data');
o_pth_sum  = fullfile('..','Step_e_Manuscript_figures','summary.mat');

for sample = 1:16
    
    disp(sample)
    
    %Load FAIP
    i_pth_FA_IA  = fullfile(i_data_pth,num2str(sample),'structure_anisotropy','ver1');
    load(fullfile(i_pth_FA_IA,'SA.mat'),'H'); disp('     SA loaded')
    
    %Load HE
    i_pth_HE  = fullfile(i_data_pth,num2str(sample),'coreg_fine','ver1');
    load(fullfile(i_pth_HE,'HE.mat'),'HE'); disp('     HE loaded')
    
    %Load HE mask
    load(fullfile(i_pth_HE,'HE_mask.mat'),'dHE_mask'); disp('     HE mask loaded')    
    
    %Load MR
    load(fullfile(i_data_pth,strcat(num2str(sample)),'coreg_fine','ver1','MR.mat')); disp('     MR loaded')
    
    %Load MD - positions
    pos = tdfread(fullfile(i_data_pth,strcat(num2str(sample)),'cell_density','QuPath','measurements.tsv')); disp('     Cell nuclei loaded')
    
    %Create and save CD
    addpath(fullfile('..','Step_a_Analyze_CD'));
    sCD{sample}  = make_celldensity_map(pos,size(HE),size(MR.MD));
    
    %Create and save ROI
    ROI_no_CNN = get_ROI(sample,MR.ROI,dHE_mask);
    
    %Save FAIP
    sHd{sample}.dJ_11 = H.dJ_11;
    sHd{sample}.dJ_12 = H.dJ_12;
    sHd{sample}.dJ_22 = H.dJ_22;
    sHd{sample}.dSA   = H.dSA;
    
    %Save MR
    sMR{sample}  = MR;

    
end

disp('     Saving to struct')
save(o_pth_sum,'sMR','sHd','sCD')
disp('     Saving to struct complete')


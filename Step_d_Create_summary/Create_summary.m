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
       
    
    %Save CNN MD
    for part = 1:4
        f_name = strcat('MAT_dan_individual_MD_efficientnet_v2_1_s',num2str(sample),'_p',num2str(part),'.mat');
        addpath('../Step_c_Analyze_CNN');
        load(fullfile('..','Step_c_Analyze_CNN','output_mat',f_name));
    end
    
    sMD_CNN{sample}.I_pred = MAT_y_pred';
    sMD_CNN{sample}.I_measured = MAT_y_true';   
    sMD_CNN{sample}.measured = measured;
    sMD_CNN{sample}.predicted = predicted;
    
    %Equalize ROI of CNN and non-CNN (few different voxels in few samples so to make sure we are comparing the same thing all the time between CNN and CD/SA models)
    sROI{sample} = equalize_CNN_non_CNN_ROI(sMD_CNN{sample}.I_measured,sMR{sample}.MD,ROI_no_CNN);    
    
    tt = test_positions_map';
    tt(sROI{sample} == 0) = 0; %Erase those indices outside of our ROI to make sure it is within tumor.
    sMD_CNN{sample}.I_test_ind = tt;
    
    %Save CNN FAIP
    for part = 1:4
        f_name = strcat('MAT_dan_individual_FA2D_efficientnet_v2_1_s',num2str(sample),'_p',num2str(part),'.mat');
        load(fullfile('..','Step_c_Analyze_CNN','output_mat',f_name));
    end
    
    sFAIP_CNN{sample}.I_pred = MAT_y_pred';
    sFAIP_CNN{sample}.I_measured = MAT_y_true';
    sFAIP_CNN{sample}.measured = measured;
    sFAIP_CNN{sample}.predicted = predicted;
    
    tt = test_positions_map';
    tt(sROI{sample} == 0) = 0; %Erase those indices outside of our ROI to make sure it is within tumor.
    sFAIP_CNN{sample}.I_test_ind = tt;
    
    
end

disp('     Saving to struct')
save(o_pth_sum,'sMR','sROI','sHd','sCD','sMD_CNN','sFAIP_CNN')
disp('     Saving to struct complete')


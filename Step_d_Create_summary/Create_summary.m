clear; clc;

i_data_pth = '/Volumes/ExtHDD4/PhD/Meningioma_ex-vivo_manuscript/data';
o_pth_sum  = fullfile('..','local_data','summary.mat');

for sample = 1:16
    
    disp(sample)
    
    %Load FAIP
    i_pth_FA_IA  = fullfile(i_data_pth,num2str(sample),'anisotropy','ver1');
    load(fullfile(i_pth_FA_IA,'IA.mat'),'H'); disp('     IA loaded')
    
    %Load HE
    i_pth_HE  = fullfile(i_data_pth,num2str(sample),'coreg_fine','ver1');
    load(fullfile(i_pth_HE,'HE.mat'),'HE','dHE_mask'); disp('     HE loaded')
    
    %Load MR
    load(fullfile(i_data_pth,strcat(num2str(sample)),'coreg_fine','ver1','MR.mat')); disp('     MR loaded')
    
    %Load MD - positions
    pos = tdfread(fullfile(i_data_pth,'QuPath_CD_data',strcat(num2str(sample)),'measurements.tsv')); disp('     Cell nuclei loaded')
    
    %Create and save CD
    addpath('../zAnalyze_CD');
    sCD{sample}  = make_celldensity_map(pos,size(HE),size(MR.MD));
    
    %Create and save ROI
    ROI_no_CNN = get_ROI(sample,MR.ROI,dHE_mask);
    
    %Save FAIP
    sHd{sample}.dJ_11 = H.dJ_11;
    sHd{sample}.dJ_12 = H.dJ_12;
    sHd{sample}.dJ_22 = H.dJ_22;
    sHd{sample}.dIA   = H.dIA;
    
    %Save MR
    sMR{sample}  = MR;
    
    %Save CNN MD
    for part = 1:3
        f_name = strcat('MAT_dan_individual_MD_efficientnet_v2_1_s',num2str(sample),'_p',num2str(part),'.mat');
        addpath('../zAnalyze_CNN');
        load(fullfile('..','zAnalyze_CNN','output_mat',f_name));
    end
    
    sMD_CNN{sample}.I_MD_pred = MAT_y_pred';
    sMD_CNN{sample}.I_MD_measured = MAT_y_true';
    sMD_CNN{sample}.measured = measured;
    sMD_CNN{sample}.predicted = predicted;

    %Equalize ROI of CNN and non-CNN (few different voxels in few samples)
    sROI{sample} = equalize_CNN_non_CNN_ROI(sMD_CNN{sample}.I_MD_measured,sMR{sample}.MD,ROI_no_CNN);

    addpath(fullfile('..','zAnalyze_CNN'));
    test_ind = find_id_test_set(sMD_CNN{sample}.I_MD_measured,sMD_CNN{sample}.measured,sMD_CNN{sample}.I_MD_pred,sMD_CNN{sample}.predicted,sROI{sample});
    test_ind = sROI{sample} .* test_ind; %some of the test inds were outside of ROI, take those only inside ROI
    sMD_CNN{sample}.test_ind = test_ind;
    
    %Save CNN FAIP
    for part = 1:3
        f_name = strcat('MAT_dan_individual_FA2D_efficientnet_v2_1_s',num2str(sample),'_p',num2str(part),'.mat');
        load(fullfile('..','zAnalyze_CNN','output_mat',f_name));
    end
    
    sFAIP_CNN{sample}.I_pred = MAT_y_pred';
    sFAIP_CNN{sample}.I_measured = MAT_y_true';
    sFAIP_CNN{sample}.measured = measured;
    sFAIP_CNN{sample}.predicted = predicted;
    
    test_ind = find_id_test_set(sFAIP_CNN{sample}.I_measured,sFAIP_CNN{sample}.measured,sFAIP_CNN{sample}.I_pred,sFAIP_CNN{sample}.predicted,sROI{sample});
    test_ind = sROI{sample} .* test_ind; %some of the test inds were outside of ROI, take those only inside ROI
    sFAIP_CNN{sample}.test_ind = test_ind;
    
end

disp('     Saving to struct')
save(o_pth_sum,'sMR','sROI','sHd','sCD','sMD_CNN','sFAIP_CNN')
disp('     Saving to struct complete')


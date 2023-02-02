clear; clc;

i_data_pth = fullfile('..','..','data');
o_pth_sum  = fullfile('..','Step_e_Manuscript_figures','summary.mat');

load(o_pth_sum);

for sample = 1:16
    
    %Save CNN MD
    for part = 1:4
        f_name = strcat('MAT_MD_efficientnet_s',num2str(sample),'_p',num2str(part),'.mat');
        addpath('../Step_c_Analyze_CNN');
        load(fullfile('..','Step_c_Analyze_CNN','output_mat',f_name));
    end
    
    sMD_CNN{sample}.I_pred = MAT_y_pred';
    sMD_CNN{sample}.I_measured = MAT_y_true';
    sMD_CNN{sample}.measured = measured;
    sMD_CNN{sample}.predicted = predicted;
    
    sMD_CNN{sample}.I_test_ind = logical(test_positions_map'); %may need to mask on the ROI
    
    
    %Save CNN FAIP
    for part = 1:4
        f_name = strcat('MAT_FAIP_efficientnet_s',num2str(sample),'_p',num2str(part),'.mat');
        load(fullfile('..','Step_c_Analyze_CNN','output_mat',f_name));
    end
    
    sFAIP_CNN{sample}.I_pred = MAT_y_pred';
    sFAIP_CNN{sample}.I_measured = MAT_y_true';
    sFAIP_CNN{sample}.measured = measured;
    sFAIP_CNN{sample}.predicted = predicted;
    
    sFAIP_CNN{sample}.I_test_ind = logical(test_positions_map'); %may need to mask on the ROI
    
    
end



if (1)
    save(o_pth_sum,'sCD','sHd','sMR','sROI','sFAIP_CNN','sMD_CNN')
end


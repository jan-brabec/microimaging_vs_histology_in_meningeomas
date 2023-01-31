clear; clc;

summary_path  = fullfile('..','Step_e_Manuscript_figures','summary.mat');
load(summary_path);


[sROI,stis_MD,stis_FAIP] = get_ROI_CNN_vs_CD_SA(sCD, sMR,sHd,sFAIP_CNN,sMD_CNN);
sROI_full = get_ROI_full();
sROI_alternative = get_ROI_alternative();

if (1)
    save(summary_path,'sCD','sHd','sMR','sFAIP_CNN','sMD_CNN','sROI','sROI_full','sROI_alternative');
end
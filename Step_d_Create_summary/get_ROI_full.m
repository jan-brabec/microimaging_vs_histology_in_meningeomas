function sROI_full = get_ROI_full(a)
% function ROI_full = get_ROI_full_alternative(a)
%
% Returns ROI from downsampled MR and HE mask for all samples and plots
% them

if nargin == 1
    sROI_full = get_ROI_full(a);
    return;
end

summary_path  = fullfile('..','Step_e_Manuscript_figures','summary.mat');
load(summary_path);

for sample = 1:16
    
    i_data_pth = fullfile('..','..','data');
    i_pth_HE  = fullfile(i_data_pth,num2str(sample),'coreg_fine','ver1');
    
    load(fullfile(i_pth_HE,'HE_mask.mat'),'dHE_mask');
    
    sROI_full{sample} = logical(sMR{sample}.ROI .* dHE_mask);
    
    
end

end


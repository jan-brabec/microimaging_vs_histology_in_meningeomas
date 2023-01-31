function sROI_alternative = get_ROI_alternative(a)
% function ROI_full = get_ROI_alternative(a)
%
% Returns ROI from downsampled MR and HE mask for all samples and plots
% them
%
% Another possibility:
%   f = @(x) imfilter(x, fspecial('gaussian', [5 5], 1.5)) > 0.99;
%   ROI = f(f(f(f(f(MR.ROI .* dHE_mask)))));


if nargin == 1
    sROI_alternative = sROI_alternative(a);
    return;
end

summary_path  = fullfile('..','Step_e_Manuscript_figures','summary.mat');
load(summary_path);

for sample = 1:16
    
    i_data_pth = fullfile('..','..','data');
    i_pth_HE  = fullfile(i_data_pth,num2str(sample),'coreg_fine','ver1');
    
    load(fullfile(i_pth_HE,'HE_mask.mat'),'dHE_mask');
    MR_ROI = sMR{sample}.ROI;
    
    switch sample
        case 1
            SE = strel('square',5);
            ROI_tmp = imfill( MR_ROI .* dHE_mask ,'holes');
            ROI_tmp = round(imerode(ROI_tmp,SE));
        case 2
            SE = strel('square',6);
            ROI_tmp = imfill( MR_ROI .* dHE_mask ,'holes');
            ROI_tmp = round(imerode(ROI_tmp,SE));
        case 3
            SE = strel('square',7);
            ROI_tmp = imfill( MR_ROI .* dHE_mask ,'holes');
            ROI_tmp = round(imerode(ROI_tmp,SE));
        case 4
            SE = strel('square',7);
            ROI_tmp = imfill( MR_ROI .* dHE_mask ,'holes');
            ROI_tmp = round(imerode(ROI_tmp,SE));
        case 5
            SE = strel('square',5);
            ROI_tmp = imfill( MR_ROI .* dHE_mask ,'holes');
            ROI_tmp = round(imerode(ROI_tmp,SE));
        case 6
            SE = strel('square',5);
            ROI_tmp = imfill( MR_ROI .* dHE_mask ,'holes');
            ROI_tmp = round(imerode(ROI_tmp,SE));
        case 7
            SE = strel('square',6);
            ROI_tmp = imfill( MR_ROI .* dHE_mask ,'holes');
            ROI_tmp = round(imerode(ROI_tmp,SE));
        case 8
            SE = strel('square',5);
            ROI_tmp = imfill( MR_ROI .* dHE_mask ,'holes');
            ROI_tmp = round(imerode(ROI_tmp,SE));
        case 9
            SE = strel('square',5);
            ROI_tmp = imfill( MR_ROI .* dHE_mask ,'holes');
            ROI_tmp = round(imerode(ROI_tmp,SE));
        case 10
            SE = strel('square',5);
            ROI_tmp = imfill( MR_ROI .* dHE_mask ,'holes');
            ROI_tmp = round(imerode(ROI_tmp,SE));
        case 11
            SE = strel('square',5);
            ROI_tmp = imfill( MR_ROI .* dHE_mask ,'holes');
            ROI_tmp = round(imerode(ROI_tmp,SE)); %improve this
        case 12
            SE = strel('square',5);
            ROI_tmp = imfill( MR_ROI .* dHE_mask ,'holes');
            ROI_tmp = round(imerode(ROI_tmp,SE));
        case 13
            SE = strel('square',5);
            ROI_tmp = imfill( MR_ROI .* dHE_mask ,'holes');
            ROI_tmp = round(imerode(ROI_tmp,SE));
        case 14
            SE = strel('square',4);
            ROI_tmp = imfill( MR_ROI .* dHE_mask ,'holes');
            ROI_tmp = round(imerode(ROI_tmp,SE));
        case 15
            SE = strel('square',5);
            ROI_tmp = imfill( MR_ROI .* dHE_mask ,'holes');
            ROI_tmp = round(imerode(ROI_tmp,SE));
        case 16
            SE = strel('square',5);
            ROI_tmp1 = imfill( MR_ROI .* dHE_mask ,'holes');
            ROI_tmp1 = round(imerode(ROI_tmp1,SE));
            
            ROI_tmp2 = MR_ROI .* dHE_mask;
            SE = strel('square',5);
            ROI_tmp2 = round(imerode(ROI_tmp2,SE));
            
            ROI_tmp = ROI_tmp1 .* ROI_tmp2;
            
    end
    
    ROI = ROI_tmp .* MR_ROI .* dHE_mask;
    
    sROI_alternative{sample} = ROI;
    
    
    
end

end








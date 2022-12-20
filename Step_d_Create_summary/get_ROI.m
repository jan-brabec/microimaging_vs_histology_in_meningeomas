function ROI = get_ROI(sample,MR_ROI,dHE_mask)
% function ROI_tmp = get_ROI(sample,MR.ROI,dHE_mask)
%
% ROI return for particular sample

% Another possibility:
%   f = @(x) imfilter(x, fspecial('gaussian', [5 5], 1.5)) > 0.99;
%   ROI = f(f(f(f(f(MR.ROI .* dHE_mask)))));

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

end


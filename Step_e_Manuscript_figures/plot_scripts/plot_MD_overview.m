clear; clf; 

%decrease in MD % 1 2 3 7 13
%no correlation % 12 8 15
%no correlation but systematic problems % 9 10 5 6
%potential coregistration problems % 4 13 14 16



%      1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16
% idx = [1 2 3 7 13 12 8 15 9 10 5 6 4 14 11 16];

idx = [3 7 ...
       12 8 ...
       10 5];
       

ha = tight_subplot(numel(idx),4,[.01,.01],[.01,.01],[.01,.01]);
load(fullfile('..','summary.mat'))


axs = 1;
for id = 1:numel(idx)
    sample = idx(id);
    
    disp(sample)
        
    CD_lims  = 1;
    dif_lims = 0.5;
    MD_lims = 1.5;
    
    if id > 1 
        MD_lims = 1;
    end
    
    MD = process_map(sMR{sample}.MD,sROI{sample},MD_lims,0);
    CD = process_map(imcomplement(sCD{sample}),sROI{sample},CD_lims,1);
    MD_pred = predict_map(CD,MD,sROI{sample},sample,11);
    MD_pred = process_map(MD_pred,sROI{sample},MD_lims,0);
    [dif_CD, c_map_CD]   = make_dif_map(MD,MD_pred, sROI{sample},dif_lims);
    
    axes(ha(axs));
    imagesc(CD)
    axis image off
    colormap(ha(axs), 'gray');
    caxis([0 CD_lims])
    
    axes(ha(axs+1));
    imagesc(MD)
    axis image off
    colormap(ha(axs+1), 'gray');
    caxis([0 MD_lims])
    
    axes(ha(axs+2));
    imagesc(MD_pred)
    axis image off
    colormap(ha(axs+2), 'gray');
    caxis([0 MD_lims])
    
    axes(ha(axs+3));
    imagesc(dif_CD);
    colormap(ha(axs+3), c_map_CD);
    caxis([-dif_lims dif_lims])
    axis image off
    
    set(gcf,'color','w');
    drawnow;
    
    axs = axs + 4;
end
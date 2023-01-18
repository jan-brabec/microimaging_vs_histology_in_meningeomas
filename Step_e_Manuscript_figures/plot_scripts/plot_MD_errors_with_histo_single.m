%plot screenshots
clear; clc;
load(fullfile('..','..','local_data','HE_screenshots_MD.mat'),'sc')
load(fullfile('..','..','local_data','summary.mat'),'sMR','sROI','sCD')
addpath('../M_functions')

pnt_col = [255 192 0]./255;
pnt_size = 15;
l_w = 6.5;

for c_exp = 1:numel(sc)
    
    figure(101)
    clf;
    ha = tight_subplot(2,4,[.01,.01],[.01,.01],[.01,.01]);
    axs = 1;
    sample = sc{c_exp}.sample;
    
    disp(sample)
    disp(sc{c_exp}.descrip)
    
    addpath('../zAnalyze_FA2D')
    
    CD_lims  = 1;
    dif_lims = 0.5;
    if sample == 3
        MD_lims = 1.5;
    else
        MD_lims = 1;
    end
    
    MD = process_map(sMR{sample}.MD,sROI{sample},MD_lims,0);
    CD = process_map(sCD{sample},sROI{sample},CD_lims,1);
    MD_pred = predict_map(CD,MD,sROI{sample},sample,11);
    MD_pred = process_map(MD_pred,sROI{sample},MD_lims,0);
    [dif_CD, c_map_CD]   = make_dif_map(MD,MD_pred, sROI{sample},dif_lims);
    
    axes(ha(axs));
    imagesc(CD);
    hold on
    plot(sc{c_exp}.MR_point(1),sc{c_exp}.MR_point(2),'o','Color',pnt_col, 'MarkerSize',pnt_size,'LineWidth',l_w)
    
    colormap(ha(axs), 'gray');
    caxis([0 CD_lims])
    axis image off
    
    axes(ha(axs+1));
    imagesc(MD);
    hold on
    plot(sc{c_exp}.MR_point(1),sc{c_exp}.MR_point(2),'o' ,'Color',pnt_col, 'MarkerSize',pnt_size,'LineWidth',l_w)
    
    colormap(ha(axs+1), 'gray');
    caxis([0 MD_lims])
    axis image off
    
    axes(ha(axs+2));
    imagesc(dif_CD);
    hold on
    plot(sc{c_exp}.MR_point(1),sc{c_exp}.MR_point(2),'o','Color',pnt_col, 'MarkerSize',pnt_size,'LineWidth',l_w)
    colormap(ha(axs+2), c_map_CD);
    caxis([-dif_lims dif_lims])
    axis image off
    
    axes(ha(axs+3)); cla; hold off;
    h5 = imagesc(sc{c_exp}.im);
    hold on;
    axis image off;
    
    axes(ha(axs+4)); cla; hold off;
    text(0,1.1,sc{c_exp}.descrip,'FontSize',30)
    axis image off;
    axes(ha(axs+5)); cla; hold off;
    axis image off;
    axes(ha(axs+6)); cla; hold off;
    axis image off;
    axes(ha(axs+7)); cla; hold off;
    axis image off;    
    
    set(gcf,'color','w');
    drawnow;
    
    axs = axs + 5;
    
%     print(sprintf('MD_errors/MD_errors_%d.png',c_exp),'-dpng','-r300')
    print(sprintf('MD_errors_%d.png',c_exp),'-dpng','-r200')
end


% print(sprintf('MD_errors.png'),'-dpng','-r500')
%plot screenshots
clear; clc;
load(fullfile('..','..','local_data','HE_screenshots_MD.mat'),'sc')
load(fullfile('..','..','local_data','summary.mat'),'sMR','sROI_ver2','sCDA_raw','sMD_ML')
addpath('../M_functions')


pnt_col = [157, 195, 230;...
    187, 101, 143;...
    255, 199, 108];

p_r  = 2.5;
p_thick = 7;
fr_thick = 40;
font_size = 10;
txt_posx = 100;
txt_posy = 150;

% different features
indx = [6   60  99;... %vessels];   
    1   81  99; ... %microcysts
    9   61  99; ... %psammoma bodies
    84  38  99]; %tissue cohesivity

sc{99}.sample = 99;
sc{99}.descrip = 'blank';
sc{99}.im = cast(ones(size(sc{1}.im))*255,'uint8');

figure(101)
clf;
ha = tight_subplot(size(indx,1),7,[.01,.01],[.01,.01],[.01,.01]);
axs = 1;

for c_exp = 1:size(indx,1)
    sample = sc{indx(c_exp,1)}.sample;
    
    disp(sample)
    disp(sc{indx(c_exp,1)}.descrip)
    disp(sc{indx(c_exp,2)}.descrip)
    disp(sc{indx(c_exp,3)}.descrip)
    
    addpath('../zAnalyze_FA2D')
    
    CD_lims  = 1;
    dif_lims = 0.5;
    if sample == 3
        MD_lims = 1.5;
    else
        MD_lims = 1;
    end
    
    MD = process_map(sMR{sample}.MD,sROI_ver2{sample},MD_lims,0);
    CD = process_map(sCDA_raw{sample},sROI_ver2{sample},CD_lims,1);
    MD_pred = predict_map(CD,MD,sROI_ver2{sample},sample,11);
    MD_pred = process_map(MD_pred,sROI_ver2{sample},MD_lims,0);
    [dif_CD, c_map_CD]   = make_dif_map(MD,MD_pred, sROI_ver2{sample},dif_lims);
    
    
    MD_pred_ML = process_map(sMD_ML{sample}.I_MD_pred,sROI_ver2{sample},MD_lims,0);
    [dif_MD_ML, c_map_ML]   = make_dif_map(MD,MD_pred_ML,sROI_ver2{sample},dif_lims);
    
    
    axes(ha(axs));
    hold off
    imagesc(CD);
    hold on
    for cc = 1:3
        if indx(c_exp,cc) ~= 99
            hold on
            [x,y] = draw_circle_pointer(p_r);
            plot(sc{indx(c_exp,cc)}.MR_point(1)+x,sc{indx(c_exp,cc)}.MR_point(2)+y,'.','Color',pnt_col(cc,:)./255,'Markersize',10);
        end
    end
    colormap(ha(axs), 'gray');
    caxis([0 CD_lims])
    axis image off
    
    axes(ha(axs+1));
    imagesc(MD);
    hold on
    for cc = 1:3
        if indx(c_exp,cc) ~= 99
            hold on
            [x,y] = draw_circle_pointer(p_r);
            plot(sc{indx(c_exp,cc)}.MR_point(1)+x,sc{indx(c_exp,cc)}.MR_point(2)+y,'.','Color',pnt_col(cc,:)./255,'Markersize',10);
        end
    end
    colormap(ha(axs+1), 'gray');
    caxis([0 MD_lims])
    axis image off
    
    axes(ha(axs+2));
    imagesc(MD_pred);
    hold on
    for cc = 1:3
        if indx(c_exp,cc) ~= 99
            hold on;
            [x,y] = draw_circle_pointer(p_r);
            plot(sc{indx(c_exp,cc)}.MR_point(1)+x,sc{indx(c_exp,cc)}.MR_point(2)+y,'.','Color',pnt_col(cc,:)./255,'Markersize',10);
        end
    end
    colormap(ha(axs+2), 'gray');
    caxis([0 MD_lims])
    axis image off
    
    axes(ha(axs+3));
    imagesc(dif_CD);
    hold on
    for cc = 1:3
        if indx(c_exp,cc) ~= 99
            hold on
            hold on;
            [x,y] = draw_circle_pointer(p_r);
            plot(sc{indx(c_exp,cc)}.MR_point(1)+x,sc{indx(c_exp,cc)}.MR_point(2)+y,'.','Color',pnt_col(cc,:)./255,'Markersize',10);
        end
    end
    colormap(ha(axs+3), c_map_CD);
    caxis([-dif_lims dif_lims])
    axis image off
    
    
    
    
    axes(ha(axs+4));
    imagesc(dif_MD_ML);
    hold on
    for cc = 1:3
        if indx(c_exp,cc) ~= 99
            hold on
            hold on;
            [x,y] = draw_circle_pointer(p_r);
            plot(sc{indx(c_exp,cc)}.MR_point(1)+x,sc{indx(c_exp,cc)}.MR_point(2)+y,'.','Color',pnt_col(cc,:)./255,'Markersize',10);
        end
    end
    colormap(ha(axs+4), c_map_ML);
    caxis([-dif_lims dif_lims])
    axis image off    
    
    
    axes(ha(axs+5)); cla; hold off;
    if indx(c_exp,1) ~= 99
        imagesc(addborder((sc{indx(c_exp,1)}.im), fr_thick, pnt_col(1,:), 'outer'));
        nCD =     CD(sc{indx(c_exp,1)}.MR_point(2),sc{indx(c_exp,1)}.MR_point(1));
        nMD =     MD(sc{indx(c_exp,1)}.MR_point(2),sc{indx(c_exp,1)}.MR_point(1));
        nDI = dif_CD(sc{indx(c_exp,1)}.MR_point(2),sc{indx(c_exp,1)}.MR_point(1));
        %         text(txt_posx,txt_posy,sprintf('CD %0.2f, MD %0.2f, \\epsilon %0.2f',nCD,nMD,nDI),'FontSize',font_size)
        %                 text(txt_posx,txt_posy,sprintf('CD %0.2f, MD %0.2f, {\\fontsize{15}\\epsilon} %0.2f',nCD,nMD,nDI),'FontSize',font_size)
        text(txt_posx,txt_posy,sprintf('CD %0.2f, MD %0.2f, $\\epsilon$ %0.2f',nCD,nMD,nDI),'FontSize',font_size,'interpreter','latex')
    end
    hold on;
    axis image off;
    
    axes(ha(axs+6)); cla; hold off;
    if indx(c_exp,2) ~= 99
        imagesc(addborder((sc{indx(c_exp,2)}.im), fr_thick, pnt_col(2,:), 'outer'));
        nCD =     CD(sc{indx(c_exp,2)}.MR_point(2),sc{indx(c_exp,2)}.MR_point(1));
        nMD =     MD(sc{indx(c_exp,2)}.MR_point(2),sc{indx(c_exp,2)}.MR_point(1));
        nDI = dif_CD(sc{indx(c_exp,2)}.MR_point(2),sc{indx(c_exp,2)}.MR_point(1));
        %         text(txt_posx,txt_posy,sprintf('CD %0.2f, MD %0.2f, \\epsilon %0.2f',nCD,nMD,nDI),'FontSize',font_size)
        %         text(txt_posx,txt_posy,sprintf('CD %0.2f, MD %0.2f, {\\fontsize{15}\\epsilon} %0.2f',nCD,nMD,nDI),'FontSize',font_size)
        text(txt_posx,txt_posy,sprintf('CD %0.2f, MD %0.2f, $\\epsilon$ %0.2f',nCD,nMD,nDI),'FontSize',font_size,'interpreter','latex')
        
        
    end
    hold on;
    axis image off;
    
    axes(ha(axs+7)); cla; hold off;
    if indx(c_exp,3) ~= 99
        imagesc(addborder((sc{indx(c_exp,3)}.im), fr_thick, pnt_col(3,:), 'outer'));
        nCD =     CD(sc{indx(c_exp,3)}.MR_point(2),sc{indx(c_exp,3)}.MR_point(1));
        nMD =     MD(sc{indx(c_exp,3)}.MR_point(2),sc{indx(c_exp,3)}.MR_point(1));
        nDI = dif_CD(sc{indx(c_exp,3)}.MR_point(2),sc{indx(c_exp,3)}.MR_point(1));
        %         text(txt_posx,txt_posy,sprintf('CD %0.2f, MD %0.2f, \\epsilon %0.2f',nCD,nMD,nDI),'FontSize',font_size)
        %                 text(txt_posx,txt_posy,sprintf('CD %0.2f, MD %0.2f, {\\fontsize{15}\\epsilon} %0.2f',nCD,nMD,nDI),'FontSize',font_size)
        text(txt_posx,txt_posy,sprintf('CD %0.2f, MD %0.2f, $\\epsilon$ %0.2f',nCD,nMD,nDI),'FontSize',font_size,'interpreter','latex')
        
    end
    hold on;
    axis image off;
    
    set(gcf,'color','w');
    drawnow;
    
    axs = axs + 7;
end

%  print(sprintf('MD_errors.png'),'-dpng','-r500')


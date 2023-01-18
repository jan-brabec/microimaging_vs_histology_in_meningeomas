%plot screenshots
clear; clc;
load(fullfile('..','..','local_data','HE_screenshots_MD.mat'),'sc')
load(fullfile('..','..','local_data','summary.mat'),'sMR','sROI','sCD')
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

% no bias
% indx = [87  86 99; ... %low and high cellularity, no bias, sample 3
%         4   3  99];    %low and high cellularity, no bias, sample 5

% %Looseness wit no bias
% indx = [75  82 32; ... %Green-black-red: From no collagen through some collagen to a lot with and also vessels
%         84  83 38; ... %Green-black-red: From collagen and compact tissue through loose tissue with less collagen to loose tissue with vessels
%         17  85 59];    %Green-black-red: Similar amount of collagen throughout but dense to loose tissue


% % % different features
% indx = [6   60  99; ... %vessels second
%         1   81  99; ... %microcysts
%         9   61  99; ... %psammoma bodies
%         10  80  99];    %bleeding - T2 high, false effect.

% different features
indx = [6   60  99; ... %vessels second
    1   81  99; ... %microcysts
    9   61  99; ... %psammoma bodies
    84  38  99];    %bleeding - T2 high, false effect.

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
    
    MD = process_map(sMR{sample}.MD,sROI{sample},MD_lims,0);
    CD = process_map(sCD{sample},sROI{sample},CD_lims,1);
    MD_pred = predict_map(CD,MD,sROI{sample},sample,11);
    MD_pred = process_map(MD_pred,sROI{sample},MD_lims,0);
    [dif_CD, c_map_CD]   = make_dif_map(MD,MD_pred,sROI{sample},dif_lims);
    
    axes(ha(axs));
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
    
    axes(ha(axs+4)); cla; hold off;
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
    
    axes(ha(axs+5)); cla; hold off;
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
    
    axes(ha(axs+6)); cla; hold off;
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

 print(sprintf('MD_errors.png'),'-dpng','-r800')


%
%
%
%
%
% % % ALL
% % indx = [1   2  26; ... %microcysts
% %         22  99 99; ... %vessels first
% %         6   60 99; ... %vessels second
% %         9   61 99; ... %psammoma bodies
% %         3   4  99; ... %no bias, same MD but high/low cellularity
% %         31  35 32; ... %Green-black-red: From no collagen through some collagen to a lot with and also vessels
% %         37  40 38; ... %Green-black-red: From collagen and compact tissue through loose tissue with less collagen to loose tissue with vessels
% %         17  19 59; ... %Green-black-red: Similar amount of collagen throughout but dense to loose tissue
% %         20  30 99; ... %CD with low MD/high MD goes with green/red bias: red somewhat more loose tissue but overall similar
% %         10  46 11; ... %Green-green-red: From bleeding through vessels to strong collagen
% %         13  14 99; ... %Green-black: dense to loose
% %         56  54 55];    %Green-red-red: from tumor to tumor undergoing degeneration and vessels region
%
%
% % % %no bias figure OLD
% % indx = [74  73 99; ... %same CD
% %         4   3  99; ...%different CD
% %         70  69 99; ...  %both different
% %         68  67 99; ...
% %         72  71 99];
%
%
% % %4 different features OLD
% % indx = [6   60 99; ... %vessels second
% %         1   2  26; ... %microcysts
% %         9   61 99; ... %psammoma bodies
% %         10  46 11];    %Green-green-red: From bleeding through vessels to strong collagen
%
% %Sample 5 green errors
% % indx = [75 76 77]; ... %sample 5 green errors to get overview

%Looseness wit no bias OLD
% indx = [75  99 32; ... %Green-black-red: From no collagen through some collagen to a lot with and also vessels
%         37  40 38; ... %Green-black-red: From collagen and compact tissue through loose tissue with less collagen to loose tissue with vessels
%         17  79 59];    %Green-black-red: Similar amount of collagen throughout but dense to loose tissue
%
% no bias OLD
% indx = [74  73 99; ... %same CD
%         4   3  99];    %different CD

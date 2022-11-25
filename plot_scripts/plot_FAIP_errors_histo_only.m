%plot screenshots
clear; clc;
load(fullfile('..','..','local_data','HE_screenshots_FAIP.mat'),'sc')
load(fullfile('..','..','local_data','summary.mat'),'sMR','sROI_ver2','sHd')
addpath('../M_functions');

pnt_col = [157, 195, 230;...
    187, 101, 143;...
    255, 199, 108];

pnt_size = 3;
l_w = 1;
fr_thick = 20;
font_size = 10;
txt_posx = 100;
txt_posy = 150;


indx = [36 37 38; ...  %high IA
        39 40 41; ... %low
        8   6 13]; %weird
    
sc{99}.sample = 99;
sc{99}.descrip = 'blank';
sc{99}.im = cast(ones(size(sc{1}.im))*255,'uint8');

figure(101)
clf;
ha = tight_subplot(size(indx,1),size(indx,2),[.01,.01],[.01,.01],[.01,.01]);

indx = indx';
indx = indx(:);


for c_exp = 1:numel(indx)
    sz(c_exp,:) = size(sc{indx(c_exp)}.im);
end

for c_exp = 1:numel(indx)
    tmp{c_exp} = imresize(sc{indx(c_exp)}.im,[mean(sz(:,1)) NaN]);
    sz2(c_exp,:) = size(tmp{c_exp});
end

for c_exp = 1:numel(indx)
    sc2plot{c_exp} = imcrop(tmp{c_exp},[1 1 min(sz2(:,2)) mean(sz(:,1))]);
end

axs = 1;
for c_exp = 1:numel(indx)
        
    axes(ha(axs)); cla; hold off;
    
    if indx(c_exp,1) ~= 99

        imagesc(sc2plot{c_exp});
        
        %This is to calculate values
        sample = sc{indx(c_exp)}.sample;
        dif_lims = 0.5;
        [lims_dir_FA2D, lims_dir_IA] = get_dir_lims(sample,0.6);
        IA   = process_map(sHd{sample}.dIA,sROI_ver2{sample},lims_dir_IA,1);
        FAIP = process_map(sMR{sample}.FA2D,sROI_ver2{sample},lims_dir_FA2D,0);
        
        for i = 1:100
            [~,test_set_measured,test_set_predicted,test_set_usedforpred] = ...
                predict_map(IA,FAIP,sROI_ver2{sample},sample,1101);
            
            R2_FAIP_IA_test_bootstrap(i) = calc_R2(test_set_measured,test_set_predicted);
        end
        
        FAIP_pred = predict_map(IA,FAIP,sROI_ver2{sample},sample,11);
        FAIP_pred = process_map(FAIP_pred,sROI_ver2{sample},lims_dir_FA2D,0);
        
        [dif_IA,c_map_IA] = make_dif_map(FAIP,FAIP_pred,sROI_ver2{sample},dif_lims);
        
        nIA   =     IA(sc{indx(c_exp)}.MR_point(2),sc{indx(c_exp)}.MR_point(1));
        nFAIP =   FAIP(sc{indx(c_exp)}.MR_point(2),sc{indx(c_exp)}.MR_point(1));
        nDI   = dif_IA(sc{indx(c_exp)}.MR_point(2),sc{indx(c_exp)}.MR_point(1));
        R2    = round(median(R2_FAIP_IA_test_bootstrap),2);
        text(txt_posx,txt_posy,sprintf('S %0.0f R$^2$ %0.2f SA %0.2f FA$_{\\textrm{IP}}$ %0.2f $\\epsilon$ %0.2f',sc{indx(c_exp)}.sample,R2,nIA,nFAIP,nDI),'FontSize',font_size,'interpreter','latex')
    end
    
    
    hold on;
    axis image off;
    
    set(gcf,'color','w');
    drawnow;
    
    axs = axs + 1;
end


print(sprintf('FAIP_errors_histo_only.png'),'-dpng','-r500')
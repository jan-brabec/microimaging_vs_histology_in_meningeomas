function check_error_FAIP(sample)
% function check_error_FAIP(sample)

load(fullfile('..','..','..','data',strcat(num2str(sample)),'coreg_fine','ver1','HE.mat'),'HE');
load(fullfile('..','summary.mat'),'sMR','sROI','sHd')
addpath(fullfile('..','M_functions'));

dif_lims = 0.5;
[lims_dir_FAIP, lims_dir_SA] = get_dir_lims(sample,0.6);

SA   = process_map(sHd{sample}.dSA,sROI{sample},lims_dir_SA,1);
FAIP = process_map(sMR{sample}.FAIP,sROI{sample},lims_dir_FAIP,0);
FAIP_pred = predict_map(SA,FAIP,sROI{sample},sample,11);
FAIP_pred = process_map(FAIP_pred,sROI{sample},lims_dir_FAIP,0);
[dif_SA,c_map_SA] = make_dif_map(FAIP,FAIP_pred,sROI{sample},dif_lims);


figure(202);
clf;
set(gcf,'color','white');
colormap gray;

ha = tight_subplot(2,3,[.01,.01],[.01,.01],[.01,.01]);

axes(ha(5)); cla; hold off;
h5 = imagesc(HE);
hold on;
axis image off;

axes(ha(6)); cla; hold off;
h10 = imagesc(HE);
hold on;
axis image off;

axes(ha(1)); cla; hold off;
h_im = imagesc(HE);
set(h_im, 'ButtonDownFcn', @im_click_A, 'userdata', [h5 h10]);
axis image off;

axes(ha(2)); cla; hold off;
h_im = imagesc(dif_SA);
set(h_im, 'ButtonDownFcn', @im_click_B, 'userdata', [h5 h10]);
colormap(ha(2), c_map_SA);
caxis([-dif_lims dif_lims])
axis image off

axes(ha(3)); cla; hold off;
h_im = imagesc(FAIP);
set(h_im, 'ButtonDownFcn', @im_click_B, 'userdata', [h5 h10]);
colormap(ha(3), 'gray');
caxis([0 lims_dir_FAIP])
axis image off

axes(ha(4)); cla; hold off;
h_im = imagesc(SA);
set(h_im, 'ButtonDownFcn', @im_click_B, 'userdata', [h5 h10]);
colormap(ha(4), 'gray');
caxis([0 lims_dir_SA])
axis image off



A_sz = size(HE);
B_sz = size(sMR{sample}.MD);

s = A_sz(1:2) ./ B_sz(1:2);
w = 2;

    function im_click_B(hx,hy)
        p = floor(hy.IntersectionPoint([2 1])) + 0.5;
        disp('----')
        disp('MR')
        disp(['point: ',num2str(round(hy.IntersectionPoint(1:2)))])
        
        
        im_zoom_A(hx.UserData(1).Parent, (p-1) .* s);
        im_zoom_B(hx.UserData(2).Parent, (p-1) .* s);
    end

    function im_click_A(hx,hy)
        p = floor(hy.IntersectionPoint([2 1])) + 0.5;
        p = floor(p ./ s) - 0.5;
        
        im_zoom_A(hx.UserData(1).Parent, (p-1) .* s);
        im_zoom_B(hx.UserData(2).Parent, (p-1) .* s);
    end

    function im_zoom_A(h, p)
        xlim(h, p(2)  + [-w w+1] * s(2) );
        ylim(h, p(1)  + [-w w+1] * s(1) );
        disp('HE')
        disp(['xlim ',num2str(round( p(1)  + [-w w+1] * s(1)))])
        disp(['ylim ',num2str(round( p(2)  + [-w w+1] * s(2)))])
        
        % show pixel grid, but first delete points
        ht = h;
        
        hold(ht,'on');
        tmp = ht.Children;
        for c = 1:numel(tmp)
            switch (class(tmp(c)))
                case 'matlab.graphics.chart.primitive.Line'
                    delete(tmp(c));
            end
        end
        
        for i = -w:(w+1)
            for j = -w:(w+1)
                
                if (j <= w)
                    plot(ht, ...
                        p(2) + j * s(2) + [0 1] * s(2), ...
                        p(1) + i * s(1) + [0 0] * s(1), ...
                        'r', 'linewidth', 1);
                end
                
                if (i <= w)
                    plot(ht, ...
                        p(2) + j * s(2) + [0 0] * s(2), ...
                        p(1) + i * s(1) + [0 1] * s(1), ...
                        'r', 'linewidth', 1);
                end
            end
        end
        
        hold on;
    end

    function im_zoom_B(h, p)
        
        xlim(h, p(2)  + [-w w+1] * s(2) );
        ylim(h, p(1)  + [-w w+1] * s(1) );
        hold on;
        
    end




end
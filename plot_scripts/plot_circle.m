clear; clf

r = linspace(0,1,10);
theta = linspace(0, 2*pi, 100);
[rg, thg] = meshgrid(r,theta);
[x,y] = pol2cart(thg,rg);
pcolor(x,y,thg);

c_map = hsv;

if (1)
    c_map = c_map(1:2:end,:);
else
    k = 1;
    for i  = 1:2:256
        tmp(k,:) = mean([c_map(i,:);c_map(i+1,:)],1);
        k = k+1;
        
    end
    c_map = tmp;
end


c_map = hsv;
c_map = c_map(1:2:end,:);
c_map = circshift(c_map,64);
c_map = [c_map; c_map];
colormap(c_map);
shading flat;
axis equal;
axis image off
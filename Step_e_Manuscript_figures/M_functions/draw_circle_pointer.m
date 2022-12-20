function [x,y] = draw_circle_pointer(r)
%[x,y] = draw_circle_pointer(r)
%
%   Return x, y to get circle pointer

theta=0:0.01:2*pi;

x = r*cos(theta);
y = r*sin(theta);

end


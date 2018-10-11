function [ck] = estimate_attenuation(I, dk_x, dk_y)
%Harris Corner detector for interest points
corners = corner(I);
[m,n,o]=size(I);

filt_size = 5;
att = zeros(m);
weight = zeros(m);
% for loop for creating patch and calculation ak

end
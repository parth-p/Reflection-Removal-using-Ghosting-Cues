function [dk_x, dk_y, ck] = estimate_dk_ck(imagepath)
I = im2double(imread(imagepath));
[m,n,o]=size(I);
if o==3
    I = rgb2gray(I);
end
img_lp = auto_corr_on_laplacian(I);
% filter_lp=[0 -1 0; -1 4 -1; 0 -1 0];
% img_lp=imfilter(I,filter_lp);
% auto_corr=xcorr2(img_lp);

lmax1=ordfilt2(img_lp,25, true(5));
lmax2=ordfilt2(img_lp,24, true(5));

[sx, sy] = size(lmax1);
% removing 4 maxima's near orign
lmax1((sx+1)/2 - 4: (sx+1)/2 + 4, (sy+1)/2 - 4: (sy+1)/2 + 4) = 0;
lmax2((sx+1)/2 - 4: (sx+1)/2 + 4, (sy+1)/2 - 4: (sy+1)/2 + 4) = 0;
indices = find(lmax1 - lmax2 < 70);

lmax1(indices) = 0;

[maxm, dk] = max(lmax1(:));
[dk_y, dk_x] = ind2sub(size(lmax1),dk);

dk_y = floor((sx)/2 + 1 - dk_y)
dk_x = floor((sy)/2 + 1 - dk_x) 
ck = estimate_attenuation(I, dk_x, dk_y)

% Visualization
figure;
title("Graph for maximums (sub. 2nd min.)");
subplot(1, 2, 1);
imagesc(lmax1);
colorbar;
subplot(1, 2, 2);
imagesc(lmax2);
end


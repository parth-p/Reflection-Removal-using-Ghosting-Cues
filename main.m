addpath('epllcode');

% bounded-LBFGS Optimization package
addpath('lbfgsb/lbfgsb3.0_mex1.2');
% J = imread(imagepath);
J = imresize(imread(imagepath),[200 300]);
I = im2double(J);
% I = imresize(I, 0.25);
[configs.dx, configs.dy, configs.c] = estimate_dk_ck(I);
configs.padding=ceil(norm([configs.dx configs.dy]))+10;
% configs.padding = 40;
[configs.h configs.w configs.nch]=size(I);
configs.num_px = configs.h*configs.w;

for i=1:configs.nch
    fprintf('Channel %d .....', i);
    temp = struct();
    temp = configs;
    temp.ch=i;
    [I_t_k I_r_k ]=patch_gmm(I(:,:,i), temp);    
      % Post-processings to enhance the results. 
      I_t(:,:,i) = I_t_k-valid_min(I_t_k, temp.padding);
      I_r(:,:,i) = I_r_k-valid_min(I_r_k, temp.padding);
      I_t(:,:,i) = match(I_t(:,:,i), I(:,:,i));
end

%Store output
imwrite(I, 'image.png');
imwrite(I_t, 't.png');
imwrite(I_r, 'r.png');

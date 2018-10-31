function [I_t I_r ] = patch_gmm(I_in, h, w, c, dx, dy)
% Setup for patch-based reconstruction 

% Identity matrix
Id_mat = speye(h*w, h*w); 

% Ghosting kernel K 
all_ids = reshape([1:h*w], [h w]);
self_ids=all_ids;
negh_ids=ncircshift(all_ids, [dy dx]);
negh_ids2=circshift(all_ids, [dy dx]);
ind=ones(h,w);
indc=ones(h,w)*c;
indc(negh_ids==0)=0;
S_plus=sparse(self_ids(:), self_ids(:), ind);
S_minus=sparse(self_ids(:), negh_ids2(:), indc);
k_mat=S_plus+S_minus;

% Operator that maps an image to its ghosted version
A = [Id_mat k_mat]; 
 
lambda = 1e6; 

% patch size for patch-GMM
psize = 8;

num_patches = (h-psize+1)*(w-psize+1);

mask=merge_two_patches(ones(psize^2, num_patches),ones(psize^2, num_patches), h, w, psize);

% Use non-negative constraint
non_negative = true;

% Parameters for half-quadratic regularization method
beta_factor = 2;
beta_i = 200;
dims = [h w];

% Setup for GMM prior
load GSModel_8x8_200_2M_noDC_zeromean.mat
excludeList=[];
%noiseSD=25/255;

% Initialization, may takes a while. 
fprintf('Init...\n');
[I_t_i I_r_i ] = grad_irls(I_in, configs);
% faster option, but results are not as good.
%[I_t_i I_r_i ] = grad_lasso(I_in, configs);


% Apply patch gmm with the initial result.
% Create patches from the two layers.
est_t = im2patches(I_t_i, psize);
est_r = im2patches(I_r_i, psize);

niter = 25;
beta  = configs.beta_i;

% loop for merging 2 best patches
% ....not commited yet due to some errors

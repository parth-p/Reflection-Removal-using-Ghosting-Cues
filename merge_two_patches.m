function out = merge_two_patches(est_t, est_r, h, w, psize)
  % Merge patches and concat
  t_merge = merge_patches(est_t, h, w, psize);
  r_merge = merge_patches(est_r, h, w, psize);
  out = cat(1, t_merge(:), r_merge(:));

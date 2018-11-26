function out = match(i,ex)
  % Match the global color flavor to 
  sig = sqrt(sum((ex-mean(ex(:))).^2)/sum((i-mean(i(:))).^2));
  out = sig*(i-mean(i(:))) + mean(ex(:)); 
  out = out;

function I=ncircshift(I, s)
% circshift but fill zero instead of circulating 
  I=padarray(I, abs(s));
  I=circshift(Ip,s);
% diff of orignal padded and circular shifted 
  I=I(abs(s(1))+1:end-abs(s(1)), abs(s(2))+1:end-abs(s(2)),:);


function [ck] = estimate_attenuation(I, dk_x, dk_y)
%Harris Corner detector for interest points
corners = corner(I);
[m,n,o]=size(I);

filt_size = 5;
att = zeros(m);
weight = zeros(m);

for i=1:m
    origin_x = corners(i,1);
    origin_y = corners(i,2);
    patch1 = gpatch(I,origin_x, origin_y,filt_size);
    
    shifted_x = origin_x + dk_y;
    shifted_y = origin_y + dk_x;
    patch2 = gpatch(I,shifted_x, shifted_y,filt_size);
    
    if(isempty(patch1)||isempty(patch2))
        continue;
    end
    patch1=patch1-mean(patch1); patch2=patch2-mean(patch2);
    var1 = max(patch1(:)) - min(patch1(:));
    var2 = max(patch2(:)) - min(patch2(:));

    att(i) = (var2/var1);
    if att(i) > 0 && att(i) < 1
        scr = sum(sum(patch1.*patch2))/(sqrt(sum(sum(patch1.^2)))*sqrt(sum(sum(patch2.^2))));
        weight(i) = exp(-scr/(2*0.2^2));
    end
end
ck = sum(weight.*att)/sum(weight);

end

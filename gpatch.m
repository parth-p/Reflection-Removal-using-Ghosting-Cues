function [p] = gpatch( I,x,y,w)
% assuming w is odd
	if ((x>w) && (y>w) &&((x+w)<size(I,2)) && ((y+w)<size(I,1)))  
	    p=I(y-w:y+w,x-w:x+w);
	else
	    p=[];
	end
end
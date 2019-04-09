function A = skew(v)
% Takes a 3*3 vector v and converts it to a skew symmetric matrix
A = zeros(3);
A = diag([v(3),v(1)],-1) + diag(-[v(3),v(1)],1) + diag(v(2),2) + diag(-v(2),-2);
end


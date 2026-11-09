function[D,counts] = betterDifferentiator(x,y)

% This function calculates the derivatives of the data at each x point and
% puts it into a vector
%
% Inputs:
%   x = vector of x data vals
%   y = vector of y data vals
%
% Outputs:
%   D = A vector of approximate derivatives of y at each x
%   counts = a vector of the number of central divided differences and
%   interp. polynomial divided differences used
% 
% Author:      Jacob Jenkins
% Section:     F
% Assignment:  Module Project 4
% Date:        11/19/2024

counts = [0;0];
D(1) = y((1)).*(2.*x(1)-x(2)-x(3))./((x(1)-x(2)).*(x(1)-x(3))) + y(2).*(2.*x(1)-x(1)-x(3))./((x(2)-x(1)).*(x(2)-x(3))) + y(3).*(2.*x(1)-x(1)-x(2))./((x(3)-x(1)).*(x(3)-x(2)));
D_first_one = y(1).*(2.*x(1)-x(2)-x(3))./((x(1)-x(2)).*(x(1)-x(3)));
D_first_two = y(2).*(2.*x(1)-x(1)-x(3))./((x(2)-x(1)).*(x(2)-x(3)));
last = length(x);
D(last) = y((last-2)).*(2.*x(last)-x(last-1)-x(last))./((x(last-2)-x(last-1)).*(x(last-2)-x(last))) + y(last-1).*(2.*x(last)-x(last-2)-x(last))./((x(last-1)-x(last-2)).*(x(last-1)-x(last))) + y(last).*(2.*x(last)-x(last-2)-x(last-1))./((x(last)-x(last-2)).*(x(last)-x(last-1)));
counts(2) = 2;
for vec = (1:length(x)-2)+1
    if x(vec)-x(vec-1) == x(vec+1)-x(vec)
            D(vec) = (y(vec+1)-y(vec-1))./(2.*(x(vec)-x(vec-1)));
            counts(1) = counts(1)+1;
    else
            D(vec) = y(vec-1).*(2.*x(vec)-x(vec)-x(vec+1))./((x(vec-1)-x(vec)).*(x(vec-1)-x(vec+1))) + y(vec).*(2.*x(vec)-x(vec-1)-x(vec+1))./((x(vec)-x(vec-1)).*(x(vec)-x(vec+1))) + y(vec+1).*(2.*x(vec)-x(vec-1)-x(vec))./((x(vec+1)-x(vec-1)).*(x(vec+1)-x(vec)));
            counts(2) = counts(2)+1;
    end
end
end


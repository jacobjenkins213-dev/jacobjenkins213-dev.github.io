function[I,counts] = betterIntegrator(x,y)

% This function integrates a data set using a combination of simpsons and
% trap rules to give a more accurate integral than matlab's standard
% integration functions
%
% Inputs:
%   x = vector of x data vals
%   y = vector of y data vals
%
% Outputs:
%   I = integral value
%   counts = a vector of the number of trap rule, simpsons 1/3 rule, and
%   simpsons 3/8 rule used to integrate
% 
% Author:      Jacob Jenkins
% Section:     F
% Assignment:  Module Project 4
% Date:        11/19/2024
I = 0;
counts = [0;0;0];
interval_length_vec_index = 0; % this value represents the x value between 
interval_lengths = x(2:length(x))-x(1:length(x)-1);% finds the step size h between each data point
len=length(interval_lengths);
while ~isempty(interval_lengths)
    n = 1;
    equal_int_count = 1;
    while n <= length(interval_lengths)-1 & ismembertol(interval_lengths(n+1),interval_lengths(n))
        equal_int_count = equal_int_count + 1;
        n = n+1;
    end
    interval_length_vec_index = interval_length_vec_index + n;
    if mod(equal_int_count,2) == 0
        if equal_int_count == 2
            dI = (interval_lengths(interval_length_vec_index)).* (y(interval_length_vec_index-1)+4.*y(interval_length_vec_index)+y(interval_length_vec_index+1))./6;
            I = I + dI;
            counts(2) = counts(2)+1;
        else
            number_simpsons = n./2;
            dataVec = y(interval_length_vec_index+1-n:interval_length_vec_index+1);
            for d=2:2:n
                    dI = interval_lengths(interval_length_vec_index).*(dataVec(d-1)+4.*dataVec(d)+dataVec(d+1))./3;
                    I = I + dI;
            end
            counts(2) = counts(2) + number_simpsons;
        end
    elseif equal_int_count == 1
        dI = (x(interval_length_vec_index+1)-x(interval_length_vec_index)).*(y(interval_length_vec_index)+y(interval_length_vec_index+1))./2;
        I = I + dI;
        counts(1) = counts(1)+1;
    elseif mod(equal_int_count,2) ~= 0
        dataVec = y(interval_length_vec_index+1-n:interval_length_vec_index+1);
        simp_onethird_data = dataVec(4:length(dataVec));
        dI_threeeight = 3./8.*interval_lengths(interval_length_vec_index).*(dataVec(1)+3.*dataVec(2)+3.*dataVec(3)+dataVec(4));
        counts(3) = counts(3)+1;
        number_simpsons = (n-3)./2;
        for d = linspace(2,number_simpsons.*2,number_simpsons)
                dI = interval_lengths(interval_length_vec_index).*(simp_onethird_data(d-1)+4.*simp_onethird_data(d)+simp_onethird_data(d+1))./3;
                I = I + dI;
        end
        counts(2) = counts(2) + number_simpsons;
        I = I + dI_threeeight;
    end
interval_lengths = interval_lengths(n+1:end);
end






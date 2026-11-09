function [T_matrix,T_center,T_quad] = nodesolver(gridrows,gridcolumns,hy,kx,ky)
% Finds the temperature gradient across an m by n grid 
T_fluid = 25; % degrees celsius
k_x = kx; % W/mK
k_y = ky; %W/mK
q_dot = 250000; % W/m^3
h_x = 100; % W/m^2K
h_y = hy; % W/m^2K (change between 5 values)
total_x = .05; % length of cross section in m
total_y = .2; %height of cross section in m
m = gridrows; % number of rows (changes)
n = gridcolumns; % number of columns (changes)
del_x = total_x/n;
del_y = total_y/m;
T = sym('T',[round(m/2) round(n/2)]); % matrix of t values
%eq = zeros([round(m/2) round(n/2)]); % matrix of equations

%% go through each node and define a heat equation
for r = 1:round(m/2)
    for c = 1:round(n/2)
%% first corner
        if r == 1 && c==1 %|| r == 1 && mod(c, 2) ~= 0 || c==1 && mod(r, 2) ~= 0 || mod(c,2) ~= 0 && mod(r,2) ~= 0
            area = (del_x).*(del_y)/4;
		    L_y = del_y/2;
		    L_x = del_x/2;
		    q_left = h_x*L_y*(T_fluid-T(r,c)); % convection
		    q_up = h_y*L_x*(T_fluid-T(r,c)); % convection
		    q_down = k_y*L_x*(T(r+1,c)-T(r,c))/del_y;
		    q_right = k_x*L_y*(T(r,c+1)-T(r,c))/del_x;
            eq = q_left + q_right + q_up + q_down + q_dot*area == 0;
            eq_mat(r,c) = eq;
        %% eq(r,c) = q_left + q_right + q_up + q_down + q_dot*area == 0
%% top side        
        elseif r == 1 && c ~= round(n/2) && c~=1
	        area = del_x*del_y/2;
	        L_y = del_y/2;
	        L_x = del_x;
		    q_left = k_x*L_y*(T(r,c-1)-T(r,c))/del_x;
		    q_right = k_x*L_y*(T(r,c+1)-T(r,c))/del_x;
		    q_up = h_y*L_x*(T_fluid-T(r,c)); % convection
		    q_down = k_y*L_x*(T(r+1,c)-T(r,c))/del_y;
            eq = q_left + q_right + q_up + q_down + q_dot*area == 0;
            eq_mat(r,c) = eq;
 % alexs contributions
 %top right corner even
        elseif r == 1 && c == round(n/2) && mod(n, 2) == 0
	        area = del_x * del_y/2;
	        eq = h_y * del_x * (T_fluid-T(r,c)) + k_x * del_y/2 * (T(r,c-1) - T(r,c))/del_x + k_y * del_x * (T(r+1,c) - T(r,c))/del_y + q_dot*area == 0;
            eq_mat(r,c) = eq;
 %top right corner odd
        elseif r == 1 && c == round(n/2) && mod(n, 2) ~= 0 
	        area = del_x * del_y/4;
	        q_left = k_x * del_y/2 *(T(r,c-1)-T(r,c))/del_x;
            q_right = 0;
            q_up = h_y * del_x/2 * (T_fluid-T(r,c));
            q_down = k_y * del_x/2 * (T(r+1,c)-T(r,c))/del_y;
            eq = q_left + q_right + q_up + q_down + q_dot*area == 0;
            eq_mat(r,c) = eq;
%left side
        elseif r~=1 && r ~= round(m/2) && c == 1
   	        area = del_x.*del_y/2;
            q_left = h_x*del_y*(T_fluid - T(r,c));
            q_right = k_x*del_y*(T(r,c+1) - T(r,c))/del_x;
            q_up = k_y*del_x/2*(T(r-1,c) - T(r,c))/del_y;
            q_down = k_y*del_x/2*(T(r+1,c) - T(r,c))/del_y;
            eq = q_left + q_up + q_right + q_down + q_dot * area == 0;
            eq_mat(r,c) = eq;
%middle  
        elseif r ~= 1 && c~= 1 && r ~= round(m/2) && c ~= round(n/2)
		    area = del_x * del_y;
            q_down = k_y*del_x*(T(r+1,c) - T(r,c))/del_y;
            q_up = k_y*del_x*(T(r-1,c) - T(r,c))/del_y;
            q_right = k_x*del_y*(T(r,c+1) - T(r,c))/del_x;
            q_left = k_x*del_y*(T(r,c-1) - T(r,c))/del_x;
            eq = q_down + q_up + q_right + q_left + q_dot * area==0;
            eq_mat(r,c) = eq;
%Right side
        elseif r~=1 && r~=round(m/2) && c == round(n/2)
            if mod(n,2) ~= 0 %% even number of columns
                area= del_x * del_y/2;
                q_left = k_x*del_y*(T(r,c-1) - T(r,c))/del_x;
                q_right = 0;
                q_up = k_y*del_x/2*(T(r-1,c) - T(r,c))/del_y;
                q_down = k_y*del_x/2*(T(r+1,c) - T(r,c))/del_y;
	            eq = q_left + q_up + q_down + q_right + q_dot * area == 0;
                eq_mat(r,c) = eq;
            else 
                area=del_x * del_y;
                q_left = k_x*del_y*(T(r,c-1) - T(r,c))/del_x;
                q_right = 0;
                q_up = k_y*del_x*(T(r-1,c) - T(r,c))/del_y;
                q_down = k_y*del_x*(T(r+1,c) - T(r,c))/del_y;
	            eq = q_left + q_up + q_down + q_right + q_dot * area == 0;
                eq_mat(r,c) = eq;
            end
%bottom left corner
        elseif r == round(m/2) && c == 1
	        if mod(m, 2) == 0 %% even rows   
                q_left = h_x * del_y*(T_fluid - T(r,c));
                q_right = k_x * del_y*(T(r,c+1)-T(r,c))/del_x;
                q_up = k_y * del_x/2*(T(r-1,c)-T(r,c))/del_y;
                q_down = 0;
	            eq =  q_left + q_right + q_up + q_down + q_dot * del_x * del_y / 2 == 0;
                eq_mat(r,c) = eq;
            else %% odd
                q_up = k_y * del_x/2 * (T(r-1,c) - T(r,c))/del_y;
                q_down = 0;
                q_left = h_x * del_y/2*(T_fluid - T(r,c));
                q_right = k_x.*del_y/2*(T(r,c+1)-T(r,c))/del_x;
                eq = q_left + q_right + q_up + q_down + q_dot*del_x*del_y/4 == 0;
                eq_mat(r,c) = eq;
            end
%bottom side 
        elseif r == round(m/2) && c~= 1 && c ~= round(n/2)
            if mod(m,2) == 0 %% even number of total rows
                area = del_x * del_y;
	            eq = k_y * del_x*(T(r-1,c) - T(r,c))/del_y + k_x * del_y*(T(r,c+1) - T(r,c))/del_x + k_x * del_y*(T(r,c-1) - T(r,c))/del_x + q_dot * area ==0; 
                eq_mat(r,c) = eq;
            else
                area = del_x * del_y/2;
	            eq = k_y * del_x*(T(r-1,c) - T(r,c))/del_y + k_x * del_y/2*(T(r,c+1) - T(r,c))/del_x + k_x * del_y/2*(T(r,c-1) - T(r,c))/del_x + q_dot * area ==0;
                eq_mat(r,c) = eq;
            end
%bottom right corner
        elseif  r == round(m/2) && c == round(n/2)
	        if mod(m,2) == 0 & mod(n,2) == 0 %% even rows and columns
	            eq =  k_x * del_y *(T(r,c-1)-T(r,c))/del_x + k_y * del_x *(T(r-1,c)-T(r,c))/del_y + q_dot*del_x*del_y == 0;
                eq_mat(r,c) = eq;
            elseif mod(m,2) == 0 & mod(n,2) == 1 %% even rows, odd columns
                eq = k_x* del_y*(T(r,c-1)-T(r,c))/(del_x) + k_y * del_x/2 *(T(r-1,c)-T(r,c))/(del_y) + q_dot * del_x * del_y /2 == 0;
                eq_mat(r,c) = eq;
            elseif mod(m,2) == 1 & mod(n,2) == 0 %% odd rows, even columns
	            eq = k_x* del_y/2*(T(r,c-1)-T(r,c))/(del_x) + k_y * del_x *(T(r-1,c)-T(r,c))/(del_y) +q_dot * del_x * del_y /2 == 0;
                eq_mat(r,c) = eq;
            elseif mod(m,2) == 1 & mod(n,2) == 1 %% odd rows and columns
	            eq = k_x * del_y/2*(T(r,c-1)-T(r,c))/(del_x) + k_y * del_x/2 *(T(r-1,c)-T(r,c))/(del_y) + q_dot * del_x * del_y /4 == 0;
                eq_mat(r,c) = eq;
            end
        end
    end
end
quad_grid_structure = solve(eq_mat,T);

%% turn structure with fractions to matrix with decimals
for r = 1:round(m/2)
    for c = 1:round(n/2)
        varname = sprintf('T%d_%d', r, c);
        quad_grid_mat(r,c) = double(quad_grid_structure.(varname));
    end
end
T_center = quad_grid_mat(round(m/2),round(n/2));
T_quad = quad_grid_mat;
% concatinate the full grid

if mod(n,2) == 0 % columns even
    top_grid = [quad_grid_mat, fliplr(quad_grid_mat)];
    if mod(m,2) == 0 % rows even
        bottom_grid = flipud(top_grid);
    else %% rows odd
        bottom_grid = flipud(top_grid(1:end-1,:));
    end
else % columns odd 
    top_right = quad_grid_mat(:,1:end-1); %% remove middle to prevent double counting
    top_grid = [quad_grid_mat, fliplr(top_right)];
    if mod(m,2) == 0 % rows even
        bottom_grid = flipud(top_grid);
    else % rows odd
        bottom_grid = flipud(top_grid(1:end-1,:));
    end
end
total_grid = [top_grid; bottom_grid];
T_matrix = total_grid;
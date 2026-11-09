2D nodal temperature solver (MATLAB)
Alex Bagnoni, David Harrington, Jacob Jenkins

nodesolver.m   function [T_matrix,T_center,T_quad] = nodesolver(gridrows,gridcolumns,hy,kx,ky)
               Steady-state 2D conduction with uniform heat generation (250,000 W/m^3),
               fluid at 25 C, h_x = 100 W/m^2K, cross-section 0.05 m by 0.2 m.
Heat_Transfer_Numerical_Project.pdf   the written report

Contour cases from the report:
  nodesolver(10,10,10,7,14)
  nodesolver(10,10,100,7,14)
  nodesolver(10,10,100,1,250)

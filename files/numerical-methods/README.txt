Better integration and differentiation (MATLAB)
Jacob Jenkins, Module Project 4, November 2024

betterIntegrator.m, betterDifferentiator.m   the two functions
better_integrator_test.m, better_differentiator_test.m   x^5 accuracy tests
engineAnalysis_Jenkins.m   runs the tests and the engine/flywheel plots
omega_plot.m, work_plot.m   angular velocity and work analysis

experimentTorqueData.csv holds the three variables the analysis scripts read from
experimentTorqueData.mat (time_acc, disp_deg_acc, T_motor_acc). To run the scripts,
load the CSV and rebuild the struct the scripts expect, for example:

  D = readmatrix('experimentTorqueData.csv');
  time_acc = D(:,1); disp_deg_acc = D(:,2); T_motor_acc = D(:,3);
  save('experimentTorqueData.mat','time_acc','disp_deg_acc','T_motor_acc');

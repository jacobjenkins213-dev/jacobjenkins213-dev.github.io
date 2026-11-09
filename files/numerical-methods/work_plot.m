% work plots
struct = load('experimentTorqueData.mat');
y = struct.T_motor_acc';
x = struct.disp_deg_acc';
t = struct.time_acc';
theta_vals = x.*pi./180;
torque_vals = y;
work_motor = betterIntegrator(theta_vals,torque_vals)
work_friction = betterIntegrator(theta_vals(224:end),torque_vals(224:end));
delta_theta = theta(end)-theta(224);
torque_friction = work_friction./delta_theta
hold on
area(theta_vals,torque_vals)
area(theta_vals,torque_friction.*ones(1,length(theta_vals)))
xlim([0,theta_vals(end)])
alpha(.5)
xlabel('Angular Displacement [rad]')
ylabel('Torque [Nm]')
total_work_friction = torque_friction.*(theta_vals(end)-theta_vals(1))
omega = betterDifferentiator(t,theta_vals);
inertia_fly = 2.*(-total_work_friction + work_motor)./(omega(end).*omega(end)-omega(1).*omega(1)) 
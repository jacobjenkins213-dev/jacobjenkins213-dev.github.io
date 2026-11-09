%omega v theta graph
struct = load('experimentTorqueData.mat');
y = struct.disp_deg_acc';
y = y.*pi./180;
x = struct.time_acc';
[derv_y,counts] = betterDifferentiator(x,y);
hold on
plot(y,derv_y,'r')
% moving average stuff
theta = y;
omega = derv_y;
initial_omega_avg = (omega(end)+omega(end-8))./2;
omega_avg = initial_omega_avg;
i = 9;
while (omega_avg - initial_omega_avg)./initial_omega_avg .*100 <= 5.9
    prev_omega_avg = omega_avg;
    omega_avg = (omega(end-i)+omega(end-i-8))./2;
    i = i + 9;
end
theta_1_index = length(theta)-i+9;
omega_1 = prev_omega_avg;
theta_1 = theta(end-i+9)
omega_2 = initial_omega_avg;
theta_2 = theta(end)
plot(theta_1.*ones(1,51),0:50,'b')
plot(theta_2.*ones(1,51),0:50,'c')
xlabel('Angle [rad]')
ylabel('Angular Velocity [rad/s]')
title('angular velocity versus angle')
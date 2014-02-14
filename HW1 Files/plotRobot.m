function plotRobot(dataStruct)
%plotRobot draws a plot of the robot's trajectory and heading in time and
%the inertial frame
%   Detailed explanation goes here

x_n = dataStruct.truthPose(:,2);
y_n = dataStruct.truthPose(:,3);
theta_n = dataStruct.truthPose(:,4);

scale = 0.1;
v_x = scale*cos(theta_n);
v_y = scale*sin(theta_n);


plot(x_n,y_n,'x');
hold on;
quiver(x_n,y_n, v_x, v_y,scale);
xlabel('truthPose x (m)'); ylabel('truthPose y (m)');
legend('Position','Heading')
end


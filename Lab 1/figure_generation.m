%part 2.4
%a Robot 1 is our robot - the spinning one
robot1_overhead = two_robot_data.truthPose;
robot2_overhead = moving_bot_data.truthPose;
%create a uniform set of data by interpolating
newtime = linspace(0,65,110)'; 

robot1_g_interp = interp1q(robot1_overhead(:,1),robot1_overhead(:,2:4),newtime); 
robot2_g_interp = interp1q(robot2_overhead(:,1),robot2_overhead(:,2:4),newtime); 

figure(1); plot(robot1_overhead(:,2), robot1_overhead(:,3));
hold on; plot(robot1_g_interp(:,1), robot1_g_interp(:,2),'r');
hold off
xlabel('Global x (m)');ylabel('Global y(m)');
legend('measured data');

%b
figure(2);plot(robot2_overhead(:,2), robot2_overhead(:,3));
hold on; plot(robot2_g_interp(:,1), robot2_g_interp(:,2),'r');
hold off
% the interpolated data looks pretty good


delta_R1_2 = robot1_g_interp-robot2_g_interp; %set robot2 at origin
delta_R2_1 = -delta_R1_2; %set robot1 at origin

%rotation matrix from global to robot = [cos(theta) sin(theta); -sin(theta)
%cos(theta)]
S1 = sin(robot1_g_interp(:,3));
C1 = cos(robot1_g_interp(:,3));
S2 = sin(robot2_g_interp(:,3));
C2 = cos(robot2_g_interp(:,3));

R1_2 = [C2.*delta_R1_2(:,1) + S2.*delta_R1_2(:,2), C2.*delta_R1_2(:,2) - S2.*delta_R1_2(:,1)];
R2_1 = [C1.*delta_R2_1(:,1) + S1.*delta_R2_1(:,2), C1.*delta_R2_1(:,2) - S1.*delta_R2_1(:,1)];

figure(3); plot(R1_2(:,1),R1_2(:,2));
figure(4); plot(R2_1(:,1),R2_1(:,2));
% R1_2 = zeros(size(delta_R1_2));
% R2_1 = zeros(size(delta_R2_1));
% 
% for i = 1:length(delta_R1_2(:,1))
%     R1_2 = ([cos(
% end



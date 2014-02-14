
%Main script for robots HW1 Benjamin Reinhardt 2/1/2014
%%
%Part 1- Changing Reference Frames
%1)
load('lidarScan.mat');
angles = -120:240/680:120;
fig1 = figure(1);clf; 
set(fig1, 'defaulttextinterpreter','tex');
plot(angles,lidarScan);
title('Lidar range data');
xlabel('lidar angle from front of robot (deg)');
ylabel('lidar scan distance (m)');
%2)
fig2 = figure(2);clf; 
set(fig2, 'defaulttextinterpreter','latex');
x_y = lidar_range2xy(lidarScan,0.2,240*pi/180,size(lidarScan,2));
plot(x_y(1,:),x_y(2,:));
title('Lidar data in robot 1 x-y coordinates');
xlabel('robot x coordinate (m)');
ylabel('robot y coordinate (m)');

%3)
pose1 = [3 -5 2*pi/3];

global_xy = robot2global(pose1,x_y);
fig3 = figure(3);clf; 
set(fig3, 'defaulttextinterpreter','latex');
plot(global_xy(1,:),global_xy(2,:));
title('Lidar data in global x-y coordinates');
xlabel('global x coordinate (m)');
ylabel('global y coordinate (m)');

%4)
pose2 = [-2,3,pi/2];
r2_xy = global2robot(pose2,global_xy);

fig4 = figure(4);clf; 
set(fig4, 'defaulttextinterpreter','latex');
plot(r2_xy(1,:),r2_xy(2,:));
title('Lidar data in robot 2 x-y coordinates');
xlabel('robot x coordinate (m)');
ylabel('robot y coordinate (m)');
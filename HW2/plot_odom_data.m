x_0 = data_noNoise.truthPose(2,2:4)';

odomData_noNoise = data_noNoise.odometry;
d_noNoise = odomData_noNoise(:,2)';
phi_noNoise = odomData_noNoise(:,3)';

odomData_noise = data_noise.odometry;
d_noise = odomData_noise(:,2)';
phi_Noise = odomData_noise(:,3)';

state_truth = data_noNoise.truthPose(:,2:4)';
int_state_noNoise = integrateOdom(x_0,d_noNoise,phi_noNoise);
int_state_noise = integrateOdom(x_0,d_noise,phi_Noise);
state_noNoise = [x_0,int_state_noNoise];
state_noise = [x_0,int_state_noise];

figure(2);
plot(state_truth(1,:),state_truth(2,:),'r');
hold on
plot(state_noNoise(1,:),state_noNoise(2,:),'g');
plot(state_noise(1,:),state_noise(2,:),'b');
hold off
legend('truth','noNoise','noise');
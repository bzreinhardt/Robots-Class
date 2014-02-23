%davenport's q method
%bi are vectors measured in body frame, r are same vectors in fixed frame
%ai are weighting variables

%setup (run this only once)
%step 1, generate N_v vectors
%step 2 rotate N_v vectors into B_v vectors through A
% add noise to B_v vectors to get meas_v vectors

% %generate true rotation matrix
% a = [-3^.5/3; 3^.5/3 ;-3^.5/3];
% phi = 2*pi/3;
% B_A_N = expm(-phi*crs(a));
% %generate true vectors in inertial frame
% N_v = normc(randn(3,50)); 
% %generate true vectors in body frame
% B_v = B_A_N*N_v;
% %generate noisy measured vectors
% z = 0.01*randn(3,50);
% for i = 1:50
%     
%     meas_V(:,i) = expm(crs(z(:,i)))*B_v(:,i); 
% end

load('HW4_vectors.mat');
n = 3:50;
pseudoInvAngle = zeros(1,length(n));
davqAngle = zeros(1,length(n));
for i = 1:length(n);
    [A_est, q_est, axis_est, phi_est] = naivePseudoInv(meas_V(:,1:n(i)), N_v(:,1:n(i)));
    [A_est2, q_est2, axis_est2, phi_est2] = davQ(meas_V(:,1:n(i)), N_v(:,1:n(i)), ones(1,n(i))/(0.01^2));
    pseudoInvAngle(i) = phi_est;
    davqAngle(i) = phi_est2;
end
piErr = abs(pseudoInvAngle - phi);
davqErr = abs(davqAngle - phi);
figure(1); clf;
plot(n,piErr,n,davqErr);legend('Pseudo Inverse Method','Davenport Q method');
xlabel('number of vectors');ylabel('absolute value of error in phi (rad)');

%do the above 100 times and average results
piErr2 = zeros(1,length(n));
davqErr2 = zeros(1,length(n));
k = 0;

while k < 100
%    generate true vectors in inertial frame
N_v2 = normc(randn(3,50)); 
%generate true vectors in body frame
B_v2 = B_A_N*N_v;
%generate noisy measured vectors
z2 = 0.01*randn(3,50);
for i = 1:50
    
    meas_V2(:,i) = expm(crs(z(:,i)))*B_v2(:,i); 
    
end
for i = 1:length(n);
    [A_est, q_est, axis_est, phi_est] = naivePseudoInv(meas_V2(:,1:n(i)), N_v2(:,1:n(i)));
    [A_est2, q_est2, axis_est2, phi_est2] = davQ(meas_V2(:,1:n(i)), N_v2(:,1:n(i)), ones(1,n(i))/(0.01^2));
    piErr2(i) =  piErr2(i) + abs( phi_est - phi);
    davqErr2(i) = davqErr2(i) + abs(phi_est2 - phi);
end
    k = k + 1;
end
piErr2 = piErr2/k;
davqErr2 = davqErr2/k;

figure(2); clf;
plot(n,piErr2,n,davqErr2);legend('Pseudo Inverse Method','Davenport Q method');
xlabel('number of vectors');ylabel('absolute value of error in phi (rad)');


    



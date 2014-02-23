function [ mu, sigma ] = KFStationary( map, measurements, mu0, sigma0  )
% gridLocalizationStationary calculates the pdf of a robot's position 
% for a discrete gridded map given range measurements
% 
%   INPUTS
%       map       	Nx4 matrix of wall endpoints (x1,y1,x2,y2)
%       measurements	N rowN,E,S,W (90,0,-90,180)  Nx4
%       mu0 - 3x1 vector of the initial guess for the robot's position
%       sigma0 - 3x2 matrix of the initial covariance matrix 
% 
%   OUTPUTS
%      mu - 3x1 vector of the position guess after all measurement updates
%       sigma - 3x3 matrix of the covariance after all measurement updates

%constants
sigmaNS = 0.1;
sigmaEW = 0.3;
robotRad = 0;
angles = [pi/2 0 -pi/2 pi];
maxRange = 3;

mu = mu0;
sigma = sigma0;
Q = diag([sigmaNS,sigmaEW,sigmaNS,sigmaEW]);

%C is the jacobian of how each measurement changes with the position
%dN/dx = 0, dN/dy = -1, dE/dx = -1, dE/dy = 0, etc
C = [0 -1; -1 0; 0 1; 1 0];
%NOTE, for HW3 beyond range is 3 - converting to making beyond range
%measurements to NaN, so that it works with the simulator and real robot.
%Change this as necessary 
%measurements(measurements == maxRange) = NaN;

% for each measurement, update the map

for i = 1:length(measurements(:,1))
    z_bar = sonarPredict([mu;0],map,robotRad,angles,maxRange); %[N;E;S;W]
    z_bar(isnan(z_bar)) = maxRange;
    %go through each measurement so you can throw away the out of range
    %ones
            %find kalman gain
            k_t = sigma * C'*inv(C*sigma*C'+Q);
            %update mu
            mu = mu+k_t*(measurements(i,:)'-z_bar);
            %update sigma
            sigma = (eye(size(sigma))-k_t*C)*sigma;
end

        
%     z_bar(isnan(z_bar)) = 3;
%    
%     Kalman gain
%     k_t = sigma * C'*inv(C*sigma*C'+Q);
%     update mu
%     find the kalman update
%     diff = measurements(i,:)' - z_bar;
%     throw away erroneous measurements
%     diff(isnan(diff)) = 0;
%     mu = mu +  k_t*diff;
%     set the NaN components of k_update to zero, so that they don't
%     actually affect the new mu 
%     update sigma
%     interesting that sigma doesn't care how well your measurements and mu
%     agree
%     sigma = (eye(size(sigma))- k_t*C)*sigma;

%algorithm
% with no movement, mu_t bar is just the previous mu_t
%mu_t = mu_t_bar + k_t*(measurement - z_bar)

%k_t = sigma_t_bar * C'*(C*sigma_t_bar*C'+Q)^-1

%sigma_t = (eye(size(sigma_t_bar))- k_t*C)*sigma_t_bar

%if measurements are [N E S W], Q = diag(sigmaNS,sigmaEW,sigmaNS,sigmaEW)

end


function [newPdf] = discreteLocationUpdate(pdf0,map,X,Y,measurement)
%discreteLocationUpdate updates the probability distribution over a
%discrete grid
% INPUTS
%     pdf - nxm matrix of probability values across the grid before accounting for measuremetns
%     map - Kx4 matrix of wall endpoints (x0,y0,x1,y1)
%     X - nxm matrix of the lower left corner x coordinate for each cell
%     Y - nxm matrix of the lower left corner y coordinate for each cell
%     measurement - 1x4 matrix of a single measurement from all sonar inputs
% OUTPUT
%     newPdf - nxm matrix of probability values given the measurements

%ASSUMPTIONS - 
% normal sized robot, 
% robot angle is always 0 degrees (pointed in positive x direction)
% sensors distributed at angles [pi/2 0 -pi/2 pi]
% sensor 1 and 3 (N and S) have noise ~N(0,0.1)
% sensor 2 and 4 (E and W) have noise ~N(0,0.3)
% maximum range of 3
%measurements taken from middle of square
%CONSTANTS
robotRad = 0.13;
sigmaNS = 0.1;
sigmaEW = 0.3;
angles = [pi/2 0 -pi/2 pi];
maxRange = 3;

dx = X(1,2) - X(1,1); dy = Y(end-1,1) - Y(end,1);
midX = X + dx; midY = Y + dy;

[n,m] = size(X);
%cycle through different squares
pdf = pdf0;
for i = 1:n
    for j = 1:m
        %only do an update for the non-wall squares
        if pdf0(i,j)~=0
        
        robotPose = [midX(i,j); midY(i,j); 0];
        %predicted noiseless ranges - these will be the mu for the normal
        %distribution
        [range] = sonarPredict(robotPose,map,robotRad,angles,maxRange);
        %p(z|x) is the probability of getting the real measurement (x) with
        %a normal distribution with a mu = expected range and a sigma as
        %specified by the sensor noise
        p_N = normpdf(measurement(1),range(1),sigmaNS);
        p_E = normpdf(measurement(2),range(2),sigmaEW); 
        p_S = normpdf(measurement(3),range(3),sigmaNS); 
        p_W = normpdf(measurement(4),range(4),sigmaEW);
        
        %updated belief is p(z|x)*bel so multiply all the measurement
        %probabilities by the current probability
        pdf(i,j) = p_N*p_E*p_S*p_W*pdf(i,j);
        end
        
    end
end
%normalize the whole distribution before returning it 
newPdf = pdf/sum(sum(pdf)); 
end
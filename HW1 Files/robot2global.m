function[xyG] = robot2global(pose,xyR)
% ROBOT2GLOBAL: transform a 2D point in robot coordinates into global
% coordinates (assumes planar world).
% 
%   XYG = ROBOT2GLOBAL(POSE,XYR) returns the 2D point in global coordinates
%   corresponding to a 2D point in robot coordinates.
% 
%   INPUTS
%       pose    robot's current pose [x y theta]  (1-by-3)
%       xyR     2D point in robot coordinates (1-by-2) or (2-by-N)
% 
%   OUTPUTS
%       xyG     2D point in global coordinates (1-by-2)
% 
% 
%   Cornell University
%   MAE 4180/5180 CS 3758: Autonomous Mobile Robots
%   Homework #1
%   Reinhardt, BENJAMIN
% make sure all robot coordinates are in 2-N-format
    if size(xyR,1) == 1
        xyR = xyR';
    end
xyR_aug = [xyR;ones(1,size(xyR,2))];
theta = pose(3);
n_R_b = [cos(theta) -sin(theta); sin(theta) cos(theta)];
n_X_b = [pose(1); pose(2)];

n_Q_b = [n_R_b n_X_b; 0 0 1];
outM = n_Q_b*xyR_aug;
if size(outM,2) == 1
    xyG = outM(1:2)';
else
    xyG = outM(1:2,:);
end



    

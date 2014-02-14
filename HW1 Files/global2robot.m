function[xyR] = global2robot(pose,xyG)
% GLOBAL2ROBOT: transform a 2D point in global coordinates into robot
% coordinates (assumes planar world).
% 
%   XYR = GLOBAL2ROBOT(POSE,XYG) returns the 2D point in robot coordinates
%   corresponding to a 2D point in global coordinates.
% 
%   INPUTS
%       pose    robot's current pose [x y theta]  (1-by-3)
%       xyG     2D point in global coordinates (1-by-2)
% 
%   OUTPUTS
%       xyR     2D point in robot coordinates (1-by-2)
% 
% 
%   Cornell University
%   MAE 4180/5180 CS 3758: Autonomous Mobile Robots
%   Homework #1
%   REINHARDT, BENJAMIN

    if size(xyG,1) == 1
        xyG = xyG';
    end
xyG_aug = [xyG;ones(1,size(xyG,2))];
theta = pose(3);
b_R_n = [cos(theta) sin(theta); -sin(theta) cos(theta)];
b_X_n = [-pose(1); -pose(2)];

b_Q_n = [b_R_n b_X_n; 0 0 1];
outM = b_Q_n*xyG_aug;
if size(outM,2) == 1
    xyR = outM(1:2)';
else
    xyR = outM(1:2,:);

end


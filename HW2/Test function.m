function [qEvolution] = TestFunHW2(qInit, distance, angle)
% Test function for MAE 4180/5180, Homework 2.  
% This function checks the student's "integrate odometry" implementation.
% 
%   INPUTS
%       qInit       Initial/previous robot configuration,  3x1 [x y theta]'
%       distance    Distance returned by DistanceSensorRoomba   1xN [m]
%       angle       Angle returned by AngleSensorRoomba        	1xN [rad]
% 
%   OUTPUTS
%       qEvolution  Evolution of the robot's configuration over time, 
%                   via "dead reckoning", i.e., integration of odometry
%                   data from encoders.                     3x(N+1) array
%                   Note that qEvolution(:,1) must be equal to qInit.

% STUDENTS: Insert a call to integradeOdom, such that the function TestFunHW2 
% outputs the following variable: qEvolution 

reckonings = integrateOdom(qInit,distance,angle);
qEvolution = [qInit,reckonings];

% Depending on how you implemented integradeOdom, you may need to call it 
% either once or repeatedly, for each of the N elements of the vectors 
% distance/angle. Nonetheless, the output qEvolution should be a 3x(N+1) array.

end
% END
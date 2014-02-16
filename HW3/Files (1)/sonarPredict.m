function[range] = sonarPredict(robotPose,map,robotRad,angles,maxRange)
% SONARPREDICT: predict the sonar range measurements for a robot operating
% in a known map.
% 
%   RANGE = SONARPREDICT(ROBOTPOSE,MAP,ROBOTRAD,ANGLES,MAXRANGE) returns 
%   the expected sonar range measurements for a robot operating in a known 
%   map. 
% 
%   INPUTS
%       robotPose   3-by-1 pose vector in global coordinates (x,y,theta)
%       map         N-by-4 matrix containing the coordinates of walls in 
%                   the environment: [x1, y1, x2, y2]
%       robotRad    robot radius (meters)
%       angles      K-by-1 vector of the angular positions of the sonar
%                   sensor(s) in robot coordinates, where 0 points forward
%       maxRange    maximum sonar range (meters)
% 
%   OUTPUTS
%       range       K-by-1 vector of sonar ranges (meters)
% 
% 
%   Cornell University
%   MAE 4180/5180 CS 3758: Autonomous Mobile Robots
%   Homework 3
%   LASTNAME, FIRSTNAME 

function[lidarXY] = lidar_range2xy(lidarR, robotRad, angRange, N)
% LIDAR_RANGE2XY: convert lidar measurements (range & bearing) into x/y
% coordinates (in robot local frame)
% 
%   LIDARXY = LIDAR_RANGE2XY(LIDARR,ROBOTRAD,ANGRANGE,N) returns the
%   x/y coordinates (in robot local frame) of lidar measurements.
% 
%   INPUTS
%       lidarR      1-by-N vector of scan ranges (meters)
%       robotRad    robot radius (meters)
%       angRange    total angular field of view of lidar (radians)
%       N           number of lidar points in scan
% 
%   OUTPUTS
%       lidarXY     2-by-N matrix of x/y scan locations
% 
%   NOTE: Assume lidar is located at front of robot and pointing forward 
%         (along robot's x-axis).
% 
%   Cornell University
%   MAE 4180/5180 CS 3758: Autonomous Mobile Robots
%   Homework #1
%   REINHARDT, BENJAMIN
% Assumptions - angles and range are with respect to the lidar unit not COM
angles = linspace(-angRange/2,angRange/2,N);
y_b = lidarR.*sin(angles);
x_b = robotRad + lidarR.*cos(angles);
lidarXY = [x_b; y_b];


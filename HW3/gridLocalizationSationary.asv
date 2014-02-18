function [ pdf ] = gridLocalizationSationary( map, measurements, gridSize )
% gridLocalizationStationary calculates the pdf of a robot's position 
% for a discrete gridded map given range measurements
% 
%   INPUTS
%       map       	Nx4 matrix of wall endpoints (x1,y1,x2,y2)
%       measurements	N rowN,E,S,W (90,0,-90,180)  Nx4
%       gridSize	Number of rows x Number of columns  	2x1 [n m]
% 
%   OUTPUTS
%       pdf An nxm matrix of probabilities that the robot will be at that
%       location

%algorithm
%for each nonzero cell, find the probability of the given NSEW measurements
% and multiply by that cell's current probability

%f(x,u,sigma) = 1/(sqrt(2*pi)*sigma) * exp(-(x-mu)^2/(2*sigma^2))
%here the mean should be the measurement given perfect sensors

%how to deal with the gridding in terms of the sensor distance. for now
%assume the mean is from the middle of the grid tile. 

%normalize

end



function TestFunHW3(map, measurements, gridSize)
% Test function for MAE 4180/5180, Homework 3.  
% This function checks the student's grid localization and stationary KF implementation.
% 
%   INPUTS
%       map       	In the same format as in HW3map.mat
%       measurements	In the same format as in stationary.txt 4xN
%       gridSize	Number of rows x Number of columns  	2x1 [n m]
% 
%   OUTPUTS
%       The function generates plots as detailed below

%~~~~~~~~~~~~~~~~~~~~~
% Grid localization
%~~~~~~~~~~~~~~~~~~~~~

% STUDENTS: Create the grid based on the input gridSize


% STUDENTS: Call the function gridLocalizationStationary to get the updated pdf


% STUDENTS: Plot the following graphs. Each graph should display the map walls and have a title.
%			- Initial pdf
%			- Final pdf after incorporating all of the measurements


%~~~~~~~~~~~~~~~~~~~~~
% Stationary KF
%~~~~~~~~~~~~~~~~~~~~~

% STUDENTS: Call the function KFStationary to get the updated pdf


% STUDENTS: Plot the following graphs. Each graph should display the map walls and have a title.
%			- Initial pdf (mean and 1-sigma covarience)
%			- Final pdf after incorporating all of the measurements (mean and 1-sigma covarience)





end
% END
function TestFunHW3(map, measurements, gridSize)
% Test function for MAE 4180/5180, Homework 3.  
% This function checks the student's grid localization and stationary KF implementation.
% 
%   INPUTS
%       map       	In the same format as in HW3map.mat Nx4 (x0,y0,x1,y1)
%       endpoints
%       measurements	In the same format as in stationary.txt Nx4
%       gridSize	Number of rows x Number of columns  	2x1 [n m]
% 
%   OUTPUTS
%       The function generates plots as detailed below

%~~~~~~~~~~~~~~~~~~~~~
% Grid localization
%~~~~~~~~~~~~~~~~~~~~~

% STUDENTS: Create the grid based on the input gridSize
[ pdf0,X,Y ] = makeGridMap(map, gridSize); %X,Y coordinates of the lower left cornder of the grid boxes

% STUDENTS: Call the function gridLocalizationStationary to get the updated pdf
[ pdf ] = gridLocalizationStationary( map, measurements, gridSize );

% STUDENTS: Plot the following graphs. Each graph should display the map walls and have a title.
%			- Initial pdf
%			- Final pdf after incorporating all of the measurements
figure(1);
clf; subplot(211)
plotPdf(X,Y,pdf0,map); xlabel('X coordinate'); ylabel('Y coordinate');
title(['Initial Distribution for Gridsize ' num2str(gridSize)])
subplot(212)
plotPdf(X,Y,pdf,map); xlabel('X coordinate'); ylabel('Y coordinate');
title(['Final Distribution Gridsize ' num2str(gridSize)])

%~~~~~~~~~~~~~~~~~~~~~
% Stationary KF
%~~~~~~~~~~~~~~~~~~~~~

% STUDENTS: Call the function KFStationary to get the updated pdf

x_max = max([map(:,1);map(:,3)]);max([map(:,1);map(:,3)]);
x_min = min([map(:,1);map(:,3)]);max([map(:,1);map(:,3)]);
y_max = max([map(:,2);map(:,4)]);max([map(:,2);map(:,4)]);
y_min = min([map(:,2);map(:,4)]);max([map(:,2);map(:,4)]);
mu0_1 = [(x_max-x_min)/2; (y_max-y_min)/2];
sigma0_1 = [((x_max-x_min)/2)^2 0; 0 ((y_max-y_min)/2)^2];
[mu, sigma] = KFStationary(map, measurements, mu0_1, sigma0_1);
 


% STUDENTS: Plot the following graphs. Each graph should display the map walls and have a title.
%			- Initial pdf (mean and 1-sigma covarience)
%			- Final pdf after incorporating all of the measurements (mean and 1-sigma covarience)
figure(2); clf;

subplot(211);
plotKalmanPdf(mu0_1,sigma0_1,map); 
title(['Initial distribution \Mu = ' num2str(mu0_1') ' var(x) =' num2str(sigma0_1(1,1))...
    ' var(y) = ' num2str(sigma0_1(2,2))]);
subplot(212)
plotKalmanPdf(mu,sigma,map); 
title('Final Distribution')




end
% END
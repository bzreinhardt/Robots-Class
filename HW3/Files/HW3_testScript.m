 TestFunHW3(HW3map,measurements,[10,10])





% measurements = dlmread('stationary.txt','\t');
% gridSize = [10,10];
% [ pdf0,X,Y ] = makeGridMap(HW3map, gridSize);
% figure(1);clf; plotPdf(X,Y,pdf0,HW3map);
% pdfNew = gridLocalizationStationary(HW3map, measurements, gridSize);
% figure(2);clf; plotPdf(X,Y,pdfNew,HW3map);
% 
% gridSize2 = [40,22];
% [ pdf0_2,X_2,Y_2 ] = makeGridMap(HW3map, gridSize2);
% figure(4);clf; plotPdf(X_2,Y_2,pdf0_2,HW3map);
% pdfNew_2 = gridLocalizationStationary(HW3map, measurements, gridSize2);
% figure(5);clf; plotPdf(X_2,Y_2,pdfNew_2,HW3map);
% 
% 
% 
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Estimated Sonar measurements part.
% truthPose = noisySonarData.truthPose;
% sonarData = noisySonarData.sonar;
% 
% map = [2.009 -4.910 2.009 4.850];
% robotRad = 0.13;
% angles = [-pi/2, 0, pi/2];
% maxRange = 3;
% 
% %sonarData(isnan(sonarData)) = 3;
% clear expectedMeasurements;
% for i = 1:length(truthPose(:,1))
%     expectedMeasurements(i,:) = sonarPredict(truthPose(i,2:4)',map,robotRad,...
%         angles,maxRange);
% end
% 
% 
% figure(3);clf;
% 
% plot(expectedMeasurements);
% hold on
% plot(sonarData(:,2:4),'--');
% hold off
% legend('R_{exp}', 'F_{exp}', 'L_{exp}','R_{meas}','F_{meas}','L_{meas}')
% xlabel('time - arbitrary units'); ylabel('sonar distance (m)');
% title('Expected and Measured Sonar Measurements');
% % subplot(221)
% % plot(expectedMeasurements(:,1)
% % subplot(222)

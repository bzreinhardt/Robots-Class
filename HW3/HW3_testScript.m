%meas = dlmread('stationary.txt','\t');
% [ pdf0,X,Y ] = makeGridMap(HW3map, [10,10]);
% figure(1);clf; plotPdf(X,Y,pdf0)
truthPose = noisySonarData.truthPose;
map = [2.009 -4.910 2.009 4.850];

for i = 1:length(truthPose(:,1))
    expectedMeasurements(i,:) = sonar
end

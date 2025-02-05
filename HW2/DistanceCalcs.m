% Script Name: Distance Calculations Script
% 
% The purpose of this script is to output the calculated distance based on
% the readings from the SONAR. 


data = readcell("Block 2 Data Template.xlsx", 'useExcel', true, 'Sheet', "Part 3.1 SONAR Measurement");
close all
roomTemp = 21.9; %Celsius
ratioSpecHeats = 1.4;
idealGasConstant = 286.9;
cTheory = sqrt((roomTemp + 273.15).*ratioSpecHeats.*idealGasConstant);

totalDataRange = (6:2005); % rows to select data from, 2000 data points total
time = cell2mat(data(totalDataRange,1)); % seconds
input = cell2mat(data(totalDataRange,2)); % volts
baseline = cell2mat(data(totalDataRange, 4)); % volts
target5000 = cell2mat(data(totalDataRange, 6)); % volts
target6250 = cell2mat(data(totalDataRange, 8)); % volts
target7500 = cell2mat(data(totalDataRange, 10)); % volts
target8250 = cell2mat(data(totalDataRange, 12)); % volts
target1000 = cell2mat(data(totalDataRange, 14)); % volts
target1100 = cell2mat(data(totalDataRange, 18)); % volts
target1200 = cell2mat(data(totalDataRange, 21)); % volts
target1300 = cell2mat(data(totalDataRange, 24)); % volts
reflection5000 = target5000 - baseline;
reflection6250 = target6250 - baseline;
reflection7500 = target7500 - baseline;
reflection8250 = target8250 - baseline;
reflection1000 = target1000 - baseline;
reflection1100 = target1100 - baseline;
reflection1200 = target1200 - baseline;
reflection1300 = target1300 - baseline;

timeRange = time <= 0.006;
figure
hold on
plot(time(timeRange), baseline(timeRange) + 5);
plot(time(timeRange), target5000(timeRange) + 5.1);
plot(time(timeRange), input(timeRange) + 5.7);
plot(time(timeRange), reflection5000(timeRange) + 4.7);
legend("Baseline", "Target (Avg)", "Input", "Reflection");
xlabel("Time (s)");

tInput = 0.0001; % seconds
tMic = 0.001425; % seconds
experimentalBias = 33;

% Calculate Distance for 0.5 meters:
[~, peakPos5000] = max(reflection5000);
tReflection5000 = time(peakPos5000 - experimentalBias); % seconds
distance5000 = calculateDistance(tInput,tMic,tReflection5000,cTheory);
fprintf("Calculated Distance (0.5m): %.4f\n", distance5000);

% Calculate Distance for 0.6250 meters:
[~, peakPos6250] = max(reflection6250);
tReflection6250 = time(peakPos6250 - experimentalBias); % seconds
distance6250 = calculateDistance(tInput,tMic,tReflection6250,cTheory);
fprintf("Calculated Distance (0.6250m): %.4f\n", distance6250);

% Calculate Distance for 0.7500 meters:
[~, peakPos7500] = max(reflection7500);
tReflection7500 = time(peakPos7500 - experimentalBias); % seconds
distance7500 = calculateDistance(tInput,tMic,tReflection7500,cTheory);
fprintf("Calculated Distance (0.7500m): %.4f\n", distance7500);

% Calculate Distance for 0.8250 meters:
[~, peakPos8250] = max(reflection8250);
tReflection8250 = time(peakPos8250 - experimentalBias); % seconds
distance8250 = calculateDistance(tInput,tMic,tReflection8250,cTheory);
fprintf("Calculated Distance (0.8250m): %.4f\n", distance8250);

% Calculate Distance for 1 meter:
[~, peakPos1000] = max(reflection1000);
tReflection1000 = time(peakPos1000 - experimentalBias); % seconds
distance1000 = calculateDistance(tInput,tMic,tReflection1000,cTheory);
fprintf("Calculated Distance (1.0m): %.4f\n", distance1000);

% Calculate Distance for 1.1000 meter:
[~, peakPos1100] = max(reflection1100);
tReflection1100 = time(peakPos1100 - experimentalBias); % seconds
distance1100 = calculateDistance(tInput,tMic,tReflection1100,cTheory);
fprintf("Calculated Distance (1.1m): %.4f\n", distance1100);

% Calculate Distance for 1.200 meter:
[~, peakPos1200] = max(reflection1200);
tReflection1200 = time(peakPos1200 - experimentalBias); % seconds
distance1200 = calculateDistance(tInput,tMic,tReflection1200,cTheory);
fprintf("Calculated Distance (1.2m): %.4f\n", distance1200);

% Calculate Distance for 1.300 meter:
[~, peakPos1300] = max(reflection1300);
tReflection1300 = time(peakPos1300 - experimentalBias); % seconds
distance1300 = calculateDistance(tInput,tMic,tReflection1300,cTheory);
fprintf("Calculated Distance (1.3m): %.4f\n", distance1300);

% plot Calculated Distance vs. Measured Distance (within 1 Meter):

measuredDistances = [1.0 1.1 1.2 1.3];
calculatedDistances = [distance1000 distance1100 distance1200 distance1300];
deviation = abs(calculatedDistances - measuredDistances);
tolerance = 0.01; % meters, defined by Julie (the Client)
withinTolerance = all(deviation < 0.01);

figure
hold on
plot(measuredDistances, measuredDistances)
plot(measuredDistances, calculatedDistances, 'o')
xlabel('Actual Distance (m)')
ylabel('Experimental Distance (m)')
xline(1.1)
title('Experimental vs. Actual Distance (beyond 1m)')
legend('Measured Distances', 'Calculated Distances', 'Deviation > 0.1')

% Script Name: Distance Calculations Script
% 
% The purpose of this script is to output the calculated distance based on
% the readings from the SONAR. 


% data = readcell("Block 2 Data Template.xlsx", 'useExcel', true, 'Sheet', "Part 3.1 SONAR Measurement");
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
fprintf("Experimental Bias: %.4f\n", experimentalBias);

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

% Measured Distances
s_encoder = 120; % ticks/rev, encoder sensitivity
D_wheel = 0.0411; % m, encoder wheel diameter
encoderWithinValues = [465 581 697 767 929];
encoderWithinDistances = round(encoderDistance(encoderWithinValues), 3, 'decimals');
encoderBeyondValues = [929 1022 1115 1208];
encoderBeyondDistances = round(encoderDistance(encoderBeyondValues), 4, 'decimals');
% plot Calculated Distance vs. Measured Distance (within 1 Meter):
withinDistances = [encoderWithinDistances(1) distance5000; encoderWithinDistances(2) distance6250; encoderWithinDistances(3) distance7500; encoderWithinDistances(4) distance8250; encoderWithinDistances(5) distance1000];
actualWithinDistances = categorical({'0.500', '0.625', '0.750', '0.825', '1.000'});
figure
barWidth = 2;
hold on
withinBar = bar(actualWithinDistances, withinDistances);
legend('Measured Distances', 'Sonar Distances');
xlabel('Expected Distances (m)')
ylabel('Distance (m)')
ylim([0.4 1.2])
title('Measured vs. Expected Distance (within 1m)')
xtips1 = withinBar(1).XEndPoints;
ytips1 = withinBar(1).YEndPoints;
labels1 = string(withinBar(1).YData);
text(xtips1,ytips1,labels1, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');
xtips2 = withinBar(2).XEndPoints;
ytips2 = withinBar(2).YEndPoints;
labels2 = string(withinBar(2).YData);
text(xtips2,ytips2,labels2, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');
% Error Bars:
withinDeviation = abs(encoderWithinDistances - [distance5000 distance6250 distance7500 distance8250 distance1000]);
% Find x-coordinates of each bar
numGroups = size(withinDistances, 1);
numBarsPerGroup = size(withinDistances, 2);
% Get bar positions
xWithinPositions = nan(numGroups, numBarsPerGroup);
for i = 1:numBarsPerGroup
    xWithinPositions(:, i) = withinBar(i).XEndPoints; % Get x-coordinates
end

% Overlay error bars (assuming sonar is first and encoder is second in each group)
errorbar(xWithinPositions(:, 1), [distance5000 distance6250 distance7500 distance8250 distance1000], withinDeviation, 'k.', 'LineWidth', 1.5);

% plot Calculated Distance vs. Measured Distance (Beyond 1 Meter):
beyondDistances = [encoderBeyondDistances(1) distance1000; encoderBeyondDistances(2) distance1100; encoderBeyondDistances(3) distance1200; encoderBeyondDistances(4) distance1300];
actualBeyondDistances = categorical({'1.000', '1.100', '1.200', '1.300'});
figure
hold on
beyondBar = bar(actualBeyondDistances, beyondDistances);
xtips3 = beyondBar(1).XEndPoints;
ytips3 = beyondBar(1).YEndPoints;
labels3 = string(beyondBar(1).YData);
text(xtips3, ytips3, labels3, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');
xtips4 = beyondBar(2).XEndPoints;
ytips4 = beyondBar(2).YEndPoints;
labels4 = string(beyondBar(2).YData);
text(xtips4,ytips4,labels4,'HorizontalAlignment','center',...
    'VerticalAlignment','bottom')
legend('Measured Distances', 'Sonar Distances');
xlabel('Expected Distances (m)');
ylabel('Distance (m)');
title('Measured vs. Expected Distance (beyond 1m)');
ylim([0.8 1.7]);


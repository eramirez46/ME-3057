%% Part 2, 3 - Calibrating the Position Sensor and Rig Deformation
close all
% gainData = readcell("Block 3 Data Template.xlsx", 'useExcel', true, 'Sheet', "Part 2");

positionCalibrationData = cell2mat(gainData(5:17, 2)); % mm
voltageCalibrationData = cell2mat(gainData(5:17, 1)); % V

[curve, goodness] = fit(voltageCalibrationData, positionCalibrationData, 'poly1');

fprintf("Position Gain: %.4f\nPosition Offset: %.4f\n", curve.p1, curve.p2);

figure
hold on
grid on
plot(voltageCalibrationData, positionCalibrationData, 'ro')
xlabel("Voltage (V)")
ylabel("Position (mm)")
title("Position Sensor Calibration - Voltage vs. Position")
annotation('textbox', [0.254285714285714,0.620476190476192,0.260357142857143,0.107142857142859], 'string', "Calibration Model: " + curve.p1 + "x + " + curve.p2);
modelVoltage = linspace(min(voltageCalibrationData), max(voltageCalibrationData), 100);
modelPosition = linspace(min(positionCalibrationData), max(positionCalibrationData), 100);
plot(modelVoltage, modelPosition, 'b');

% rigDeformationData = readcell("Block 3 Data Template.xlsx", "useExcel", true, 'Sheet', 'Part 3');
rigDeformationDataRange = 4:13443;
positionRig = cell2mat(rigDeformationData(rigDeformationDataRange, 5));
forceRig = cell2mat(rigDeformationData(rigDeformationDataRange, 2));
[curveRig, goodnessRig] = fit(forceRig, positionRig, fittype({'x^2','x'}))


%% Part 4 Climbing Sling Failure Testing

% climbingSlingData = readcell("Block 3 Data Template.xlsx", 'useExcel', true, 'Sheet', 'Part 4');

dataRange = 2720:19058; % total columns: 28083, breaking point: 19058
positionClimbing = cell2mat(climbingSlingData(dataRange, 5));
forceClimbing = cell2mat(climbingSlingData(dataRange, 2));
figure
[denoisedPosition_mm, denoisedForce_N] = smoothForceDisplacementData(positionClimbing, forceClimbing);
plot(denoisedPosition_mm, denoisedForce_N)





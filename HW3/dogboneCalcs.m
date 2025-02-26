%% Part 2, 3 - Calibrating the Position Sensor and Rig Deformation
close all
% gainData = readcell("Block 3 Data Template.xlsx", 'useExcel', true, 'Sheet', "Part 2");

positionCalibrationData = cell2mat(gainData(5:17, 2)); % mm
voltageCalibrationData = cell2mat(gainData(5:17, 1)); % V
kValue = 2;
[curve, goodness] = fit(voltageCalibrationData, positionCalibrationData, 'poly1');
positionUncertainty = goodness.rmse .* kValue;
positionFitData = feval(curve, voltageCalibrationData);
fprintf("Position Gain: %.4f\nPosition Offset: %.4f\n", curve.p1, curve.p2);

figure
hold on
grid on
plot(voltageCalibrationData, positionCalibrationData, 'Marker', '.', 'Color', 'k', 'MarkerSize', 10)
plot(voltageCalibrationData, positionFitData, 'Color', 'b', 'LineWidth', 1.2)
plot(voltageCalibrationData, positionFitData + positionUncertainty, 'LineStyle', '--', 'Color', 'r')
plot(voltageCalibrationData, positionFitData - positionUncertainty, 'LineStyle', '--', 'Color', 'r')
xlabel('Sensor Position (mm)')
ylabel('Voltage (V)')
fprintf('The displacement range is 0mm to  %.2f mm\n', 10.*positionUncertainty)

% rigDeformationData = readcell("Block 3 Data Template.xlsx", "useExcel", true, 'Sheet', 'Part 3');
rigDeformationDataRange = 4:13443;
[curveRig, goodnessRig] = fit(forceRig, positionRig, fittype({'x^2','x'}));
figure
hold on
scatter(forceRig./1000, positionRig, 'bo', 'DisplayName', 'Deformation Data')
% F_fit = linspace(min(forceRig), max(forceRig), 100)
% D_fit = curveRig(F_fit)
% plot(F_fit ./ 1000, D_fit)


%% Part 4 Climbing Sling Failure Testing

% climbingSlingData = readcell("Block 3 Data Template.xlsx", 'useExcel', true, 'Sheet', 'Part 4');

dataRange = 2720:19058; % total columns: 28083, breaking point: 19058
positionClimbing = cell2mat(climbingSlingData(dataRange, 5));
forceClimbing = cell2mat(climbingSlingData(dataRange, 2));
figure
hold on
[denoisedPosition_mm, denoisedForce_N] = smoothForceDisplacementData(positionClimbing, forceClimbing);
denoisedForce_N = denoisedForce_N - min(denoisedForce_N);
denoisedForce_kN = denoisedForce_N./1000
denoisedPosition_mm = denoisedPosition_mm - min(denoisedPosition_mm)
plot(denoisedPosition_mm, denoisedForce_N, 'o')
D_corrected_mm = denoisedPosition_mm - Quad_Rig_Fit(denoisedForce_N);
maximumCorrection = max(curveRig(denoisedForce_N));
plot(D_corrected_mm, denoisedForce_N, 'o')

xlabel('\DeltaL (mm)')
ylabel('Force (N)')
title('Climbing Sling Deformation: Pre vs. Post Rig Deformation')

F_fail_N = denoisedForce_N(end)  % Force at failure
D_fail_mm = D_corrected_mm(end)  % Displacement at failure

[curveClimbing, goodnessClimbing] = fit(denoisedForce_N, denoisedPosition_mm, 'poly1')
uncertaintyClimbing = goodnessClimbing.rmse.*kValue
uncertaintyClimbingRange = uncertaintyClimbing.*10  






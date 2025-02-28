%% Part 2, 3 - Calibrating the Position Sensor and Rig Deformation
close all
load("gainData.mat");
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
load('rigDeformationData.mat')
[curveRig, goodnessRig] = fit(forceRig, positionRig, fittype({'x^2','x'}));


%% Part 4 Climbing Sling Failure Testing

load('climbingSlingData.mat')
figure
hold on
[denoisedPosition_mm, denoisedForce_N] = smoothForceDisplacementData(positionClimbing, forceClimbing);
denoisedForce_N = denoisedForce_N - min(denoisedForce_N);
denoisedForce_kN = denoisedForce_N./1000
denoisedPosition_mm = denoisedPosition_mm - min(denoisedPosition_mm)
plot(denoisedPosition_mm, denoisedForce_N, 'o')
load("Part_3_Data_Eric_M.mat");
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







data = readcell("Block 3 Data Template.xlsx", 'useExcel', true, 'Sheet', "Part 2");

positionData = cell2mat(data(5:17, 2)); % mm
voltageData = cell2mat(data(5:17, 1)); % V

[curve, goodness] = fit(voltageData, positionData, 'poly1');

fprintf("Position Gain: %.4f\nPosition Offset: %.4f\n", curve.p1, curve.p2);
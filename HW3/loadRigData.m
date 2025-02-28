gainData = readcell("Block 3 Data Template.xlsx", 'useExcel', true, 'Sheet', "Part 2");
positionCalibrationData = cell2mat(gainData(5:17, 2)); % mm
voltageCalibrationData = cell2mat(gainData(5:17, 1)); % V
rigDeformationData = readcell("Block 3 Data Template.xlsx", "useExcel", true, 'Sheet', 'Part 3');
rigDeformationDataRange = 4:13443;
positionRig = cell2mat(rigDeformationData(rigDeformationDataRange, 5));
forceRig = cell2mat(rigDeformationData(rigDeformationDataRange, 2));
climbingSlingData = readcell("Block 3 Data Template.xlsx", 'useExcel', true, 'Sheet', 'Part 4');
dataRange = 2720:19058; % total columns: 28083, breaking point: 19058
positionClimbing = cell2mat(climbingSlingData(dataRange, 5));
forceClimbing = cell2mat(climbingSlingData(dataRange, 2));

save("gainData", "voltageCalibrationData", "positionCalibrationData");
save("rigDeformationData", "positionRig", "forceRig");
save("climbingSlingData", "positionClimbing", "forceClimbing");

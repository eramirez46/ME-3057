% forceData = readcell("Block 3 Data Template.xlsx", 'useExcel', true, 'Sheet', 'Part 1');
% forceDataRange = setdiff(4:17, 14);
% forceCalibrationData = cell2mat(forceData(forceDataRange, 2)); % N
% voltageForceCalibrationData = cell2mat(forceData(forceDataRange, 3)); % V
% gainData = readcell("Block 3 Data Template.xlsx", 'useExcel', true, 'Sheet', "Part 2");
% positionCalibrationData = cell2mat(gainData(5:17, 2)); % mm
% voltageCalibrationData = cell2mat(gainData(5:17, 1)); % V
% rigDeformationData = readcell("Block 3 Data Template.xlsx", "useExcel", true, 'Sheet', 'Part 3');
% rigDeformationDataRange = 4:13443;
% positionRig = cell2mat(rigDeformationData(rigDeformationDataRange, 5));
% forceRig = cell2mat(rigDeformationData(rigDeformationDataRange, 2));
% climbingSlingData = readcell("Block 3 Data Template.xlsx", 'useExcel', true, 'Sheet', 'Part 4');
% dataRange = 2720:19058; % total columns: 28083, breaking point: 19058
% positionClimbing = cell2mat(climbingSlingData(dataRange, 5));
% forceClimbing = cell2mat(climbingSlingData(dataRange, 2));
% boltData = readcell("Block 3 Data Template.xlsx", 'useExcel', true, 'Sheet', 'Part 5');
forceBolt1 = cell2mat(boltData(cellfun(@isnumeric, boltData(:, 2)), 2)); % N
dispBolt1 = cell2mat(boltData(cellfun(@isnumeric, boltData(:, 5)), 5)); % mm
forceBolt2 = cell2mat(boltData(cellfun(@isnumeric, boltData(:, 8)), 8)); % N
dispBolt2 = cell2mat(boltData(cellfun(@isnumeric, boltData(:, 11)), 11)); % mm
forceBolt3 = cell2mat(boltData(cellfun(@isnumeric, boltData(:, 14)), 14)); % N
dispBolt3 = cell2mat(boltData(cellfun(@isnumeric, boltData(:, 17)), 17)); % mm
forceBolt4 = cell2mat(boltData(cellfun(@isnumeric, boltData(:, 20)), 20)); % N
dispBolt4 = cell2mat(boltData(cellfun(@isnumeric, boltData(:, 23)), 23)); % mm
forceBolt5 = cell2mat(boltData(cellfun(@isnumeric, boltData(:, 26)), 26)); % N
dispBolt5 = cell2mat(boltData(cellfun(@isnumeric, boltData(:, 29)), 29)); % mm
% dogboneData = readcell("Block 3 Data Template.xlsx", 'useExcel', true, 'Sheet', 'Part 6');
forceDogbone = cell2mat(dogboneData(cellfun(@isnumeric, dogboneData(:, 2)), 2)); % N
dispDogbone = cell2mat(dogboneData(cellfun(@isnumeric, dogboneData(:, 5)), 5)); % mm
% save("gainData", "voltageCalibrationData", "positionCalibrationData");
% save("rigDeformationData", "positionRig", "forceRig");
% save("climbingSlingData", "positionClimbing", "forceClimbing");
% save('forceSensorData', 'forceCalibrationData', 'voltageForceCalibrationData');
save('boltData', 'forceBolt1', 'forceBolt2', 'forceBolt3', 'forceBolt4', 'forceBolt5', ...
    'dispBolt1', 'dispBolt2', 'dispBolt3', 'dispBolt4', 'dispBolt5');
save('dogboneData', 'forceDogbone', 'dispDogbone');
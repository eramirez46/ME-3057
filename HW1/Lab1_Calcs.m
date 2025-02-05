close all

data = readcell("Block 1 Data Template.xlsx");

% 5x Amp Section
inputVoltage = cell2mat(data(9:19, 1));
CH3Five = cell2mat(data(9:19, 4));

% figure
% plot(inputVoltage, CH3Five, '-s');

% 20x Amp Section
CH3Twenty = cell2mat(data(9:19, 9));

% figure
% plot(inputVoltage, CH3Twenty, '-s')

[FO GoodnessFive] = fit(inputVoltage, CH3Twenty, 'poly1');


bodeFive = readcell("Block 1 Bode 5x Team 5.csv");
bodeTwenty = readcell("Block 1 Bode 20x team 5.csv");

gainFive = cell2mat(bodeFive(2:82, 2));
gainTwenty = cell2mat(bodeTwenty(2:82, 2));

frequencyFive = cell2mat(bodeFive(2:82, 1));
frequencyTwenty = cell2mat(bodeTwenty(2:82, 1));
decibelsFive = 20.*log10(gainFive);
deciblesTwenty = 20.*log10(gainTwenty);

subplot(2, 1, 1)
semilogx(frequencyFive, decibelsFive, 'kx')
subplot(2, 1, 2)
% semilogx(frequencyTwenty, phase_deg, 'kx')





% Function Name: calculateDistance
% The purpose of this function is to calculate the distance between the
% target and the SONAR. 
%
% tInput - time of first peak of input wave (stimulus), assumed to be in
% seconds
% tMic - time of first peak of baseline (microphone)
% tReflection - time of first peak of reflection wave (post-target
% reflection)
% vSound - theoretical speed of sound in m/s
% calculatedDistance - calculated distance between SONAR and target in
% meters

function calculatedDistance = calculateDistance(tInput,tMic,tReflection, Vsound)

tDeltaMic = tMic - tInput;
tDeltaTarget = tReflection - tMic;

dMic2Source = Vsound.*tDeltaMic;
dTarget2Mic = Vsound.*(tDeltaTarget/2);

calculatedDistance = round((dMic2Source + dTarget2Mic), 3);

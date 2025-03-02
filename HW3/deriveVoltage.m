% Function Name: deriveVoltage
%
% Based on the structure of a poly1 fit equation:
% "force = voltage*gain + offset"
% 
% This function rearranges the equation to solve for the input (in the case
% of this block, input is Voltage (V))
function derivedVoltage = deriveVoltage(force, gain, offset)
derivedVoltage = (force - offset)./(gain);
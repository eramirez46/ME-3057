function [ disp, force ] = smoothForceDisplacementData( displacement_raw, force_raw )
%smoothForceDisplacementData() de-noises data from force transducer by
%   averaging force values for data at the same displacement. Returns array
%   of unique displacement values and the averaged force values for those
%   displacements.
% Peter Griffiths 6/26/2018

% Get the unique displacement values
disp = unique(displacement_raw);
% Initialize array for force averages same size as unique displacements
force = zeros(size(disp));
% Loop through unique displacements
for i = 1:length(disp)
    % Get current displacement from array
    current_disp = disp(i);
    % Get indices of displacements matching current
    current = ( displacement_raw == current_disp );
    % Average force values associated with current displacement
    force(i) = mean( force_raw(current) );
end

end


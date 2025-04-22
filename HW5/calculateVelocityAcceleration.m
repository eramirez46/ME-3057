function [ velocity, acceleration ] = calculateVelocityAcceleration( time, displacement )
%calculateVelocityAcceleration() calculates a 2nd order finite difference 
% approximation of the velocity and acceleration using time and 
% displacement data. Takes into account changes in time step size between 
% data points.
% Created by Peter Griffiths 9/5/2019

% Get data information
numPts = length(time);

% Initialize output vectors
velocity = zeros(size(time));
acceleration = zeros(size(time));

% Calculate initial value
t0 = time(1); t1 = time(2); t2 = time(3);
x0 = displacement(1); x1 = displacement(2); x2 = displacement(3);
velocity(1) = calculateVelocity( t0, t1, t2, x0, x1, x2);
acceleration(1) = calculateAcceleration( t0, t1, t2, x0, x1, x2);

% Calculate inner values
i = 2:numPts-1;
t0 = time(i); t1 = time(i-1); t2 = time(i+1);
x0 = displacement(i); x1 = displacement(i-1); x2 = displacement(i+1);
velocity(i) = calculateVelocity( t0, t1, t2, x0, x1, x2);
acceleration(i) = calculateAcceleration( t0, t1, t2, x0, x1, x2);

% Calculate final values
t0 = time(end); t1 = time(end-1); t2 = time(end-2);
x0 = displacement(end); x1 = displacement(end-1); x2 = displacement(end-2);
velocity(end) = calculateVelocity( t0, t1, t2, x0, x1, x2);
acceleration(end) = calculateAcceleration( t0, t1, t2, x0, x1, x2);

end

%% Sub-Functions
function [ v0 ] = calculateVelocity( t0, t1, t2, x0, x1, x2)
dt1 = t1-t0; dt2 = t2-t0;
v0 = (dt1.^2.*x2-dt2.^2.*x1-(dt1.^2-dt2.^2).*x0)./(dt1.^2.*dt2-dt1.*dt2.^2);
end

function [ a0 ] = calculateAcceleration( t0, t1, t2, x0, x1, x2)
dt1 = t1-t0; dt2 = t2-t0;
a0 = (dt1.*x2-dt2.*x1-(dt1-dt2).*x0)./(0.5.*(dt1.*dt2.^2-dt1.^2.*dt2));
end
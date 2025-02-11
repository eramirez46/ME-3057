function encoderDistance = encoderDistance(tickCount)

s_encoder = 120; % ticks/rev, encoder sensitivity
D_wheel = 0.0411; % m, encoder wheel diameter
encoderDistance = tickCount.*(1/s_encoder).*D_wheel.*pi; % m, boom displacements
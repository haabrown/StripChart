function [ Temp ] = TMP100( byte )

bits1  = 1; % The bit sign bit
bits2 = 1; % The remaining bits
Temp = (-1*bits1)+uint8(bits2); % Result is in degrees C

% Depending on how this works, may end up removing bits1 and bits2 and
% doing all the work inside the Temp equation.
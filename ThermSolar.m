function [ Temp ] = ThermSolar(byte)

if byte == 255
    Temp = -982; % The limit of the incoming function
    return
end
inter = 1/((255/double(uint8(byte)))-1);
Temp = (28.54*inter^3)-(158.5*inter^2)+(474.8*inter)-319.85;
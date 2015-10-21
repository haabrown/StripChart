function [ Cur ] = Curs(byte)

Cur = double(uint8(byte))*0.064; % Result is in amps
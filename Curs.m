function [ Cur ] = Curs(byte)

Cur = double(uint8(hex2dec(byte)))*0.064; % Result is in amps
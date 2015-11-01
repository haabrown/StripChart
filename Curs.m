function [ Cur ] = Curs(byte)

Cur = double(uint8(byte))*0.016; % Result is in amps
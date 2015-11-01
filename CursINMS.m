function [ Cur ] = CursINMS(byte)

Cur = double(uint8(byte))*0.008; % Result is in amps
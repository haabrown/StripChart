function [ Cur ] = CursBatt(byte)

Cur = (14/255)*byte; % Result is in amps
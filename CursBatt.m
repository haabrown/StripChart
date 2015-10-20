function [ Cur ] = CursBatt(byte)

Cur = (14/255)*double(uint8(byte)); % Result is in amps
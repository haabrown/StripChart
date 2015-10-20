function [ Cur ] = CursBatt(byte)

Cur = (14/255)*double(uint8(hex2dec(byte))); % Result is in amps
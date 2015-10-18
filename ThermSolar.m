function [ Temp ] = ThermSolar(byte)

inter = 1/((255/byte)-1);
Temp = (28.54*inter^3)-(158.5*inter^2)+(478.8*inter)-319.85;
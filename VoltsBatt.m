function [ Volt ] = VoltsBatt(byte)

Volt = (16/255)*byte; % Volts
function [ Temp ] = ThermBatt(bytes)

inter = log(2.32/((4095/double(uint16(bytes)))-1));
Temp = (1/((1/298.15)+(inter/3450)))-273.15; % Degrees Celcius
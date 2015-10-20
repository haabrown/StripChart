function [ updated, binary, data ] = GetData(i)
    % GetData Converts a housekeeping packet into a new data column
    %   The GetData function polls the UART line to see if housekeeping
    %   data is available - if so, it will convert it into a column of data
    %   in the format used by strip1.m
    
    % For now this just dummy updates data at every loop iteration
    
    updated = 1; % 1 for an update, 0 for no change
    z = sin(2*pi*i/1000)+2;
    z2 = -1*z;
    if mod(i,2) == 0
        z3 = z;
    else
        z3 = z2;
    end
    
    % It appears that a housekeep packet is 128 bytes, with 34 of those
    % containing the information we need to plot
    
    binary = 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa';
    voltages = [binary(44),binary(45),binary(46),binary(50),binary(51),binary(61),binary(66),binary(42),binary(43),binary(69),binary(70),0]
        % Missing the INMS TH Voltage
    currents = [binary(47),binary(48),binary(49),binary(52),binary(53),binary(62),binary(63),binary(71),binary(72),0]
        % Missing the INMS TH Current
    temps = [ThermBatt(binary(54:55)),ThermBatt(binary(56:57)),binary(60),binary(58),binary(59),binary(64),binary(65),binary(41),binary(74)]
    %data = {z;z3;z;z2;z;z2;z;z2;z;z2;z;z2;z;z3;z;z2;z;z2;z;z2;z;z2;z;z2;...
      %  20*z;20*z2;20*z;20*z2;20*z;20*z2;20*z};
    data = [voltages,currents,temps]';
end
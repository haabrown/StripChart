function [ binary, data ] = GetData(sObj)
    % GetData Converts a housekeeping packet into a new data column
    %   The GetData function polls the UART line to see if housekeeping
    %   data is available - if so, it will convert it into a column of data
    %   in the format used by strip1.m
    
    % It appears that a housekeep packet is 128 bytes, with 34 of those
    % containing the information we need to plot
    
    
    binary = fread(sObj,128);
    %ibinary = ones(128,1)*dec2hex(10);
    %binary = hex2dec(ibinary);
    voltages = [Volts(binary(44)),Volts(binary(45)),Volts(binary(46)),Volts(binary(50)),Volts(binary(51)),VoltsBatt(binary(61)),double(binary(66)),VoltsCDH5(binary(42)),VoltsCDHB(binary(43)),Volts(binary(69)),Volts(binary(70))];
        % Missing the INMS TH Voltage
    currents = [Curs(binary(47)),Curs(binary(48)),Curs(binary(49)),Curs(binary(52)),Curs(binary(53)),CursBatt(binary(62)),CursBatt(binary(63)),Curs(binary(71)),Curs(binary(72))];
        % Missing the INMS TH Current
    inter1 = dec2hex(binary(54:55));
    inter2 = dec2hex(binary(54:55));
    inter1 = strcat(inter1(1,:),inter1(2,:));
    inter2 = strcat(inter2(1,:),inter2(2,:));
    temps = [ThermBatt(hex2dec(inter1)),ThermBatt(hex2dec(inter2)),ThermSolar(binary(60)),ThermSolar(binary(58)),ThermSolar(binary(59)),TMP100(binary(64)),TMP100(binary(65)),TMP100(binary(41)),TMP100(binary(74)),INMSTrans(binary(73))];
    %data = {z;z3;z;z2;z;z2;z;z2;z;z2;z;z2;z;z3;z;z2;z;z2;z;z2;z;z2;z;z2;...
      %  20*z;20*z2;20*z;20*z2;20*z;20*z2;20*z};
    data = [voltages,currents,temps]';
   	data = num2cell(data);
end
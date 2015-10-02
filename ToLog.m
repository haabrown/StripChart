function [ ] = ToLog( datum, logfile )
    % ToLog Logs an incoming data column to the provided log file.
    
    dlmwrite(logfile,datum','-append'); % Transpose column to row and log
end
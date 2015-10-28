function [ s ] = CleanupTest( s )
%UCleanupTest Tests the onCleanup function to see if MATLAB actually works.

fopen(s);
closeFID = onCleanup(@() fclose(s));
deleteFID = onCleanup(@() delete(s));
out = fscanf(s)
tic
out = fread(s,128)
toc

end


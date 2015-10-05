function [ newdata ] = TurnRed( table, newdata, i )
%TurnRed Turns a given cell red because it went out of bounds
%   Turns a cell red and passes the red cells forward

label = newdata(i,1);
colergen = @(color,text) ['<html><table border=0 width=400 bgcolor=',color,'><TR><TD>',text,'</TD></TR> </table></html>'];
newdata(i,1) = {colergen('#FF0000',label{1})};
set(table,'data',newdata);

end


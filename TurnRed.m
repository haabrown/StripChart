function [ newdata ] = TurnRed( table, newdata, i )
%TurnRed Turns a given cell red because it went out of bounds
%   Turns a cell red and passes the red cells forward

label = newdata(i,1);
value = newdata(i,2);
colergen = @(color,text) ['<html><table border=0 width=400 FONT color="white" bgcolor=',color,'><TR><TD>',text,'</TD></TR> </table></html>'];
newdata(i,1) = {colergen('#FF0000',label{1})};
newdata(i,2) = {colergen('#FF0000', num2str(value{1}))};
set(table,'data',newdata);

end


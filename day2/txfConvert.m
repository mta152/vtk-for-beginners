function txfout = txfConvert(txfin)
% this function convert KARBS transformation format to VTK transformation
% format
    temp = reshape(txfin(1:9),3,3)';        % Account for the difference between VTK and the KARBS data structure
    txfout = [[temp,txfin(10:12)'];[0 0 0 1]];
end
    
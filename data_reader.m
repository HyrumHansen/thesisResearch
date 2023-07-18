% Data Reader
% -----------
function[dat] = data_reader(x)
    dat = [str2num(cell2mat(table2array(x)))];
end
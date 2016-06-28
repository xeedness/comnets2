function [ meanV, e ] = Conf( file )
fileID = fopen(file,'r');

tline = fgets(fileID);
expr = '[\w\s]*user\[\d*\][\w\s]*';


while ischar(tline)
    tline = fgets(fileID);
    %[match] = regexp(tline,expr,'match')
    k = findstr('total bits', tline);
    k2 = findstr('user[', tline);
    if(isempty(k) == false && isempty(k2) == false) 
        split = strsplit(tline, ' ');
        totalbits = str2double(split(length(split)));
        userstr = char(regexp(tline,expr, 'match'));
        userNr = str2num(userstr(6:length(userstr)-1));
        result(userNr+1,1) = userNr; 
        result(userNr+1,2) = totalbits/(300*1000); 
    end    
end

fclose(fileID);


x = result(:,2)   ;                  % Create Data
SEM = std(x)/sqrt(length(x));               % Standard Error
ts = tinv([0.05  0.95],length(x)-1);      % T-Score
CI = mean(x) + ts*SEM;% Confidence Intervals

meanV = mean(x);
e = mean(x)-CI(1);
end


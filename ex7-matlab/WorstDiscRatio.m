function [ maxRatio, userNr ] = WorstDiscRatio( file )
fileID = fopen(file,'r');

tline = fgets(fileID);
expr = '[\w\s]*user\[\d*\][\w\s]*';


while ischar(tline)
    tline = fgets(fileID);
    %[match] = regexp(tline,expr,'match')
    k = findstr('"packets sent"', tline);
    if(isempty(k) == false) 
        split = strsplit(tline, ' ');
        send = str2double(split(length(split)));
        userstr = char(regexp(tline,expr, 'match'));
        userNr = str2num(userstr(6:length(userstr)-1));
        result(userNr+1,1) = userNr;
        result(userNr+1,2) = send; 
         
    end
    
    k = findstr('"packets received"', tline);
    if(isempty(k) == false) 
        split = strsplit(tline, ' ');
        recv = str2double(split(length(split)));
        userstr = char(regexp(tline,expr, 'match'));
        userNr = str2num(userstr(6:length(userstr)-1));
        result(userNr+1,3) = recv;
    end
    
    k = findstr('"discarded packets"', tline);
    if(isempty(k) == false) 
        split = strsplit(tline, ' ');
        disc = str2double(split(length(split)));
        userstr = char(regexp(tline,expr, 'match'));
        userNr = str2num(userstr(6:length(userstr)-1));
        result(userNr+1,4) = disc;
    end
    
end

fclose(fileID);
i = 1;
while i <= length(result) 
   if(result(i,3) == 0)
      result(i,:) = [];
   else
      i = i+1;
   end
end

maxRatio = 0;
userNr = 0;
for i = 1:length(result)
    discardedRatio = result(i,4) / result(i,3);
    if(maxRatio < discardedRatio)
        maxRatio = discardedRatio;
        userNr = result(i,1);
    end
end

end


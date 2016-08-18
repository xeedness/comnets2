file = '../examTask/trace_13.txt';
fileID = fopen(file,'r');

tline = fgets(fileID);
expr = '[\w\s]*user\[\d*\][\w\s]*';

result = [];
while ischar(tline)
    traceV = str2double(tline);
    result(length(result)+1) = traceV; 
    tline = fgets(fileID);
end

fclose(fileID);


x = result';
poissonChi2Test( x, 15, 0.039);
%SEM = std(x)/sqrt(length(x));               % Standard Error
%ts = tinv([0.05  0.95],length(x)-1);      % T-Score
%CI = mean(x) + ts*SEM;% Confidence Intervals

%meanV = mean(x);
%e = mean(x)-CI(1);



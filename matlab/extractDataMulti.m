function [ result ] = extractDataMulti( fileBase, fileStartNr, fileEndNr, searchArray )
%EXTRACTDATASCA Extracts specific vectors out of a number of .sca files
%   fileBase contains the path to result data file up to the run number
%   fileStartNr denotes the first run number
%   fileEndNr denotes the last run number
%   The search array contains the modulename and parameter name to look at
%   The data is extracted for each row
%   The result contains the extracted values for each row in the search
%   array
    result = zeros(1+(fileEndNr-fileStartNr),size(searchArray,1));
    fprintf('Starting Multiple Value Extraction.');
    for fileIt=fileStartNr:fileEndNr
        fprintf('Progress: %1.02f\n', (fileIt-fileStartNr)/(fileEndNr-fileStartNr));
        file = strcat(fileBase,num2str(fileIt),'.sca');
        


        fileID = fopen(file,'r');
        tline = fgets(fileID);
        


        while ischar(tline)
            for searchIt=1:size(searchArray,1)
                module = searchArray{searchIt,1};
                module_cont = searchArray{searchIt,2};
                param = searchArray{searchIt,3};
                %expr = '[\w\s]*user\[\d*\][\w\s]*';
                expr = strcat(module,'\[\d*\][\w\s]*');
                %[match] = regexp(tline,expr,'match')
                k = findstr(module, tline);
                k2 = findstr(module_cont, tline);
                k3 = findstr(param, tline);
                if(isempty(k) == false && isempty(k2) == false && isempty(k3) == false) 
                    split = strsplit(tline, ' ');
                    value = str2double(split(length(split)));
                    %userstr = char(regexp(tline,expr, 'match'));
                    %modNr = str2num(userstr(length(module)+2:length(userstr)-1));                    
                    result(fileIt+1,searchIt) = result(fileIt+1,searchIt)+value;
                end 
            end
            tline = fgets(fileID);
        end
        fclose(fileID);
        
        
    end
end


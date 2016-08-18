function [ result ] = extractDataSca( fileBase, fileStartNr, fileEndNr, searchArray )
%EXTRACTDATASCA Extracts specific vectors out of a number of .sca files
%   fileBase contains the path to result data file up to the run number
%   fileStartNr denotes the first run number
%   fileEndNr denotes the last run number
%   The search array contains the modulename and parameter name to look at
%   The data is extracted for each row
%   The result contains the extracted values for each row in the search
%   array
    result = [];
    for fileIt=fileStartNr:fileEndNr
        file = strcat(fileBase,num2str(fileIt),'.sca');
        


        fileID = fopen(file,'r');
        tline = fgets(fileID);
        
        
        while ischar(tline)
            for searchIt=1:size(searchArray,2)
                module = searchArray{searchIt,1};
                param = searchArray{searchIt,2};
                k = findstr(module, tline);
                k2 = findstr(param, tline);
                if(isempty(k) == false && isempty(k2) == false) 
                    split = strsplit(tline, ' ');
                    value = str2double(split(length(split)));
                    result(fileIt+1, searchIt) = value; 
                end    
            end
            
            tline = fgets(fileID);
        end
        
        fclose(fileID);
        
        
    end
end


function [ result ] = extractDataMultiByMod( fileBase, fileStartNr, fileEndNr, module, searchArray )
%EXTRACTDATASCA Extracts specific vectors out of a number of .sca files
%   fileBase contains the path to result data file up to the run number
%   fileStartNr denotes the first run number
%   fileEndNr denotes the last run number
%   The module denotes the module the results are grouped by
%   The search array contains the final module name and parameter name to look at
%   The data is extracted for each row
%   The result contains the extracted values for each row in the search
%   array

    result = zeros(1+(fileEndNr-fileStartNr),size(searchArray,1));
    fprintf('Starting Multiple Value Extraction.');
    for fileIt=fileStartNr:fileEndNr
        fprintf('Progress: %1.02f\n', (fileIt-fileStartNr)/(fileEndNr-fileStartNr));
        file = strcat(fileBase,num2str(fileIt),'.sca');
        cModules = 0;


        fileID = fopen(file,'r');
        tline = fgets(fileID);
        


        while ischar(tline)
            for searchIt=1:size(searchArray,1)
                module_cont = searchArray{searchIt,1};
                param = searchArray{searchIt,2};
                expr = strcat(module,'\[\d*\][\w\s]*');
                k = findstr(module, tline);
                k2 = findstr(module_cont, tline);
                k3 = findstr(param, tline);
                if(isempty(k) == false && isempty(k2) == false && isempty(k3) == false) 
                    split = strsplit(tline, ' ');
                    value = str2double(split(length(split)));
                    modNrStr = char(regexp(tline,expr, 'match'));
                    modNr = str2num(modNrStr(length(module)+2:length(modNrStr)-1));                    
                    if(modNr > cModules)
                        cModules = modNr;
                    end
                    result(fileIt+1,searchIt) = result(fileIt+1,searchIt)+value;
                end 
            end
            tline = fgets(fileID);
        end
        fclose(fileID);
        
        %Amount instead of last index
        cModules = cModules + 1;
        for searchIt=1:size(searchArray,1)
            result(fileIt+1,searchIt) = result(fileIt+1,searchIt) / cModules;
        end
        
    end
end


function [ result ] = extractDataHist( fileBase, fileStartNr, fileEndNr, searchArray )

    result = [];
    for fileIt=fileStartNr:fileEndNr
        file = strcat(fileBase,num2str(fileIt),'.sca');
        


        fileID = fopen(file,'r');
        tline = fgets(fileID);
        
        
        while ischar(tline)
            for searchIt=1:size(searchArray,1)
                module = searchArray{searchIt,1};
                param = searchArray{searchIt,2};
                subparam = searchArray{searchIt,3};
                k = findstr(module, tline);
                k2 = findstr(param, tline);
                if(isempty(k) == false && isempty(k2) == false) 
                    while(true)
                        k3 = findstr(subparam, tline);
                        if(isempty(k3) == false)
                            split = strsplit(tline, ' ');
                            value = str2double(split(length(split)));
                            result(fileIt+1, searchIt) = value;
                            break
                        else
                            tline = fgets(fileID);
                        end
                    end
                end    
            end
            
            tline = fgets(fileID);
        end
        
        fclose(fileID);
        
        
    end
end


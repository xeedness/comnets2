function [ resMean, resE ] = confIntervals( data, repititions, alpha )
%CONFINTERVALS Calculates confidence intervals multiple parameters
%   data is a |Param|X|Value| matrix
%   repititions contain the number of repetitions
%   the result is a vector of mean values and confindence intervals 
    resMean = [];
    resE = [];
    for paramIt=1:size(data,2)
        for runIt=1:repititions:size(data,1)
            x = data(runIt:runIt+repititions-1, paramIt);
            SEM = std(x)/sqrt(length(x));    
            ts = tinv([alpha  1-alpha],length(x)-1);      % T-Score
            CI = mean(x) + ts*SEM;% Confidence Intervals
            resMean(paramIt, ((runIt-1)/repititions)+1) = mean(x); 
            resE(paramIt, ((runIt-1)/repititions)+1) = mean(x)-CI(1);
        end
    end
end


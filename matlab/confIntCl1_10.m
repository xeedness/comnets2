% This script calculates the confidence intervals for the lateRatios of the
% voip/video streams of the profesors and conference laptops and plots them

% fileBase contains the path to result data file up to the run number
fileBase = '../results/second/low_numbers-';
% fileStartNr denotes the first run number
fileStartNr = 0;
% fileEndNr denotes the last run number
fileEndNr = 99;
% the search array contains the modulename and parameter name to look at
% the data is extracted for each row
searchArray = {'ExamTaskNetwork.ProfessorsLaptop.udpApp[0]','lateRatio';
    'ExamTaskNetwork.ConferenceLaptop.udpApp[0]','lateRatio'}
[ result ] = extractDataSca( fileBase, fileStartNr, fileEndNr, searchArray );

repititions = 10;
alpha = 0.05;
% calculate confidence intervals
[mean, e] = confIntervals( result, repititions, alpha);

%multiply by 100 to get %
mean = mean .* 100;
e = e .* 100;

%plot each row of mean and confidence intervals
% A row corresponds to the row in the search array
for i=1:size(mean, 1)
    plotConf(strcat(searchArray{i,1},' - ', searchArray{i,2}), mean(i,:), e(i,:), '# of clients', '%');
end

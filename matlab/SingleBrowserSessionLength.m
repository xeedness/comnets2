% extract the session lengths of a single browser and plot them (w
% confidence intervals)

simtime = 1000;
repititions = 15;
alpha = 0.05;
%Prepend folder for result set
imageDirectory = 'images/finalcctv/';
%The amount of clients
x = [1,5,10,15,20,30,40,50,60];
% fileBase contains the path to result data file up to the run number
fileBase = '../results/final1-cctv160820/ExamTaskNetwork-'
% fileStartNr denotes the first run number
fileStartNr = 0;
% fileEndNr denotes the last run number
fileEndNr = 134;

%erstmal nur für 1 plotten (ist das wirklich nur für 1?!)
searchArray = {'BrowsingLaptop','tcpApp[0]', 'numActiveSessions:timeavg'};

% TOSO: muss ich mit den daten noch was machen? 
[ result ] = extractDataMulti(fileBase, fileStartNr, fileEndNr, searchArray);
modResults = [result];

%calculate confidence intervals
[mean, e] = confIntervals( modResults, repititions, alpha)

% TODO: korrekte y einheit?
resultArray = {'Browser', 'average session duration', 'seconds?'};

%plot each row of mean and confidence intervals
% A row corresponds to the row in the search array
for i=1:size(mean, 1)
    title = strcat(resultArray{i,1},' - ', resultArray{i,2});
    yunit = resultArray{i,3};
    plotConf(imageDirectory, title, x, mean(i,:), e(i,:), '# of clients', yunit);
end






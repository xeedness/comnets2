simtime = 1000;
repititions = 15;
alpha = 0.05;
%Prepend folder for result set
imageDirectory = 'images/finalnocctv/';
%The amount of clients
x = [1,5,10,15,20,30,40,50,60];


% fileBase contains the path to result data file up to the run number
fileBase = '../results/final1-nocctv-160820/ExamTaskNetwork_no_CCTV-'
% fileStartNr denotes the first run number
fileStartNr = 0;
% fileEndNr denotes the last run number
fileEndNr = 134;
% the search array contains the modulename and parameter name to look at
% the data is extracted for each row
searchArray = {'BrowsingLaptop','tcpApp[0]', 'rcvdPk:sum(packetBytes)';
    'BrowsingLaptop','tcpApp[0]','sentPk:sum(packetBytes)'}
[ result ] = extractDataMulti( fileBase, fileStartNr, fileEndNr, searchArray);

throughputRcvdBrowser = result(:,1) ./ simtime;
throughputSendBrowser = result(:,2) ./ simtime;

modResults = [throughputSendBrowser throughputRcvdBrowser];

% calculate confidence intervals
[mean, e] = confIntervals( modResults, repititions, alpha);

resultArray = { 'Browser', 'send throughput all','bytes/s';
                'Browser', 'rcvd throughput all','bytes/s'}
            
%plot each row of mean and confidence intervals
% A row corresponds to the row in the search array
for i=1:size(mean, 1)
    title = strcat(resultArray{i,1},' - ', resultArray{i,2});
    yunit = resultArray{i,3};
    plotConf(imageDirectory, title, x, mean(i,:), e(i,:), '# of clients', yunit);
end
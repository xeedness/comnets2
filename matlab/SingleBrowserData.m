%This script is intended to extract the throughput of a single browser
% This script calculates the confidence intervals for the lateRatios of the
% voip/video streams of the profesors and conference laptops and plots them

simtime = 500;
repititions = 10;
alpha = 0.05;
%Prepend folder for result set
imageDirectory = 'images/trial1/';
%The amount of clients
x = [1,5,10,20,40,60,80];
% fileBase contains the path to result data file up to the run number
fileBase = '../results/trial1-cctv-160818/ExamTaskNetwork-'
% fileStartNr denotes the first run number
fileStartNr = 0;
% fileEndNr denotes the last run number
fileEndNr = 69;

searchArray = {'tcpApp[0]', 'rcvdPk:sum(packetBytes)';
    'tcpApp[0]','sentPk:sum(packetBytes)'}
module = 'ExamTaskNetwork.BrowsingLaptop'
[ result ] = extractDataMultiByMod( fileBase, fileStartNr, fileEndNr, module, searchArray);


throughputRcvdBrowserSingle = result(:,1) ./ simtime;
throughputSendBrowserSingle = result(:,2) ./ simtime;

%queueAvgWaitRemote = result2(:,1);
%queueAvgWaitMain = result2(:,2);
modResults = [throughputRcvdBrowserSingle throughputSendBrowserSingle];



% calculate confidence intervals
[mean, e] = confIntervals( modResults, repititions, alpha);


resultArray = {'Browser', 'rcvd throughput single', 'bytes/s';
                'Browser', 'send throughput single', 'bytes/s'}
            
%plot each row of mean and confidence intervals
% A row corresponds to the row in the search array
for i=1:size(mean, 1)
    title = strcat(resultArray{i,1},' - ', resultArray{i,2});
    yunit = resultArray{i,3};
    plotConf(imageDirectory, title, x, mean(i,:), e(i,:), '# of clients', yunit);
end

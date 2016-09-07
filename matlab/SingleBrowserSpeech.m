%This script is intended to extract the throughput of a single browser
% This script calculates the confidence intervals for the lateRatios of the
% voip/video streams of the profesors and conference laptops and plots them

simtime = 1000;
repititions = 15;
alpha = 0.05;
%Prepend folder for result set
imageDirectory = 'images/speechcctv/';
%The amount of clients
x = [1,5,10,15,20,30,40,50,60];
%x = [1,5,10];
% fileBase contains the path to result data file up to the run number
%fileBase = '../results/final2-nocctv-160821/ExamTaskNetwork_no_CCTV-'
fileBase = '../results/final2-cctv-160821/ExamTaskNetwork-'
% fileStartNr denotes the first run number
fileStartNr = 0;
% fileEndNr denotes the last run number
fileEndNr = 134;
%fileEndNr = 44;

% calculate browser throughput stats
searchArray = {'tcpApp[0]', 'rcvdPk:sum(packetBytes)';
    'tcpApp[0]','sentPk:sum(packetBytes)';
    'tcpApp[0]','numActiveSessions:timeavg';
    'tcpApp[0]','numSessions:last'};
module = 'BrowsingLaptop';
[ result ] = extractDataMultiByMod( fileBase, fileStartNr, fileEndNr, module, searchArray);

throughputRcvdBrowserSingle = result(:,1) ./ (result(:,3) .* simtime);
throughputSendBrowserSingle = result(:,2) ./ (result(:,3) .* simtime);

avgSessionLengthBrowser = (result(:,3) .* simtime) ./ result(:,4);
% calculate session length stats
%searchArray = {'BrowsingLaptop','tcpApp[0]', 'numActiveSessions:timeavg'};
%[ SessionLength ] = extractDataMulti(fileBase, fileStartNr, fileEndNr, searchArray);

%queueAvgWaitRemote = result2(:,1);
%queueAvgWaitMain = result2(:,2);
modResults = [throughputRcvdBrowserSingle throughputSendBrowserSingle avgSessionLengthBrowser];

% calculate confidence intervals
[mean, e] = confIntervals( modResults, repititions, alpha)

resultArray = {'Browser', 'rcvd throughput single', 'bytes/s';
                'Browser', 'send throughput single', 'bytes/s';
                'Browser', 'average session duration', 'seconds'}
 
            
          
titleSize = 20;            
            
%plot each row of mean and confidence intervals
% A row corresponds to the row in the search array
param = 'HTTP Session Duration';
xlab = '# of clients';
ylab = 'seconds';
l = {'Conference Laptop'};
figure('Name',param)
hold on;
errorbar(x,mean(3,:),e(3,:),'LineWidth',1);
ylabel(ylab);
xlabel(xlab);
%legend(l,'Location','northwest');
title(param,'FontSize', titleSize);
if ~exist(imageDirectory,'dir')
    mkdir(imageDirectory);
end
print(strcat(imageDirectory,param), '-dpng');



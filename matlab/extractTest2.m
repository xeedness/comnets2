% This script calculates the confidence intervals for the lateRatios of the
% voip/video streams of the profesors and conference laptops and plots them

simtime = 50;
repititions = 1;
alpha = 0.05;
%Prepend folder for result set
imageDirectory = 'images/finalnocctv/';
%The amount of clients
%x = [1,5,10,15,20,30,40,50,60];
x = [1,5,10,15,20,30,40,50];


% fileBase contains the path to result data file up to the run number
fileBase = '../examTask/results/ExamTaskNetwork_no_CCTV-'
% fileStartNr denotes the first run number
fileStartNr = 0;
% fileEndNr denotes the last run number
fileEndNr = 7;
% the search array contains the modulename and parameter name to look at
% the data is extracted for each row
searchArray = {'RemoteAccessPoint.wlan[0].mac','rcvdPkFromLL:sum(packetBytes)';
    'RemoteAccessPoint.wlan[0].mac','sentDownPk:sum(packetBytes)';
    'RemoteAccessPoint.wlan[0].mac','number of collisions'}
[ result ] = extractDataSca( fileBase, fileStartNr, fileEndNr, searchArray );
throughputFromClients = (result(:,1) .* 8) ./ (simtime*1024*1024);
throughputToClients = (result(:,2) .* 8) ./ (simtime*1024*1024);
throughput = throughputFromClients+throughputToClients;

collisions = result(:,3);


%queueAvgWaitRemote = result2(:,1);
%queueAvgWaitMain = result2(:,2);
modResults = [throughputFromClients'
              throughputToClients'
              throughput'
              collisions']';

% calculate confidence intervals
[mean, e] = confIntervals( modResults, repititions, alpha);


resultArray = {'RAP','throughput from clients','Mbps';
    'RAP','throughput to clients','Mbps';
    'RAP','throughput combined','Mbps';
    'RAP','number of collisions','# of collisions'};
            
%plot each row of mean and confidence intervals
% A row corresponds to the row in the search array
for i=1:size(mean, 1)
    title = strcat(resultArray{i,1},' - ', resultArray{i,2});
    yunit = resultArray{i,3};
    plotConf(imageDirectory, title, x, mean(i,:), e(i,:), '# of clients', yunit);
end

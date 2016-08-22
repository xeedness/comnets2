% This script calculates the confidence intervals for the lateRatios of the
% voip/video streams of the profesors and conference laptops and plots them

simtime = 100;
repititions = 15;
%repititions = 1;
alpha = 0.05;
%Prepend folder for result set
imageDirectory = 'images/finalnocctv/';
%The amount of clients
x = [1,5,10,15,20,30,40,50,60];
%x = [1,5,10];


% fileBase contains the path to result data file up to the run number
fileBase = '../results/final2-nocctv-160821/ExamTaskNetwork_no_CCTV-'
%fileBase = '../examTask/results/ExamTaskNetwork-'
% fileStartNr denotes the first run number
fileStartNr = 0;
% fileEndNr denotes the last run number
fileEndNr = 134;
%fileEndNr = 2;
% the search array contains the modulename and parameter name to look at
% the data is extracted for each row
searchArray = {'ProfessorsLaptop.udpApp[0]','"packets sent"';
    'ProfessorsLaptop.udpApp[0]','"packets received"';
    'ProfessorsLaptop.udpApp[0]','"discarded packets"';
    'ConferenceLaptop.udpApp[0]','"packets sent"';
    'ConferenceLaptop.udpApp[0]','"packets received"';
    'ConferenceLaptop.udpApp[0]','"discarded packets"';
    'RemoteRouter.ppp[0].queue','dropPk:count';
    'RemoteRouter.ppp[0].queue','rcvdPk:count';
    'RemoteRouter.ppp[0].queue','queueLength:timeavg';
    'MainRouter.ppp[0].queue','dropPk:count';
    'MainRouter.ppp[0].queue','rcvdPk:count';
    'MainRouter.ppp[0].queue','queueLength:timeavg';
    'RemoteAccessPoint.wlan[0].mgmt','dropPkByQueue:count';
    'RemoteAccessPoint.wlan[0].mac','rcvdPkFromHL:count';
    'Internet.eth[0].mac', 'txPk:sum(packetBytes)';
    'ProfessorsLaptop.eth[0].mac','txPk:sum(packetBytes)';
    'RemoteAccessPoint.wlan[0].mac','sent and received bits';
    'RemoteAccessPoint.wlan[0].mac','number of collisions';
    'Internet.tcpApp[1]', 'rcvdPk:sum(packetBytes)';
    'MainRouter.ppp[0].inputHook[0]', 'avg throughput (bit/s)'
    'MainRouter.ppp[0].outputHook[0]', 'avg throughput (bit/s)';
    'ConferenceLaptop.udpApp[0]','"discarded packets"';
    'RemoteAccessPoint.wlan[0].mgmt', 'dataQueueLen:timeavg';}


[ result ] = extractDataSca( fileBase, fileStartNr, fileEndNr, searchArray );
searchArray2 = {'MainRouter.ppp[0].queue','queueingTime:histogram', 'mean';
    'RemoteRouter.ppp[0].queue','queueingTime:histogram', 'mean'}
%[ result2 ] = extractDataHist( fileBase, fileStartNr, fileEndNr, searchArray2 );

lossRatiosProf = (result(:,4) - (result(:,2)-result(:,3))) ./(result(:,4));
lossRatiosConf = (result(:,1) - (result(:,5)-result(:,6))) ./(result(:,1));
lossRatiosProf = lossRatiosProf .* 100;
lossRatiosConf = lossRatiosConf .* 100;
dropRatioRemote = result(:,7) ./ (result(:,7) + result(:,8));
dropRatioMain = result(:,10) ./ (result(:,10) + result(:,11));
dropRatioRemote = dropRatioRemote .* 100;
dropRatioMain = dropRatioMain .* 100;

avgQueueLengthRemote = result(:,9);
avgQueueLengthMain = result(:,12);
dropRatioRAP = result(:,13) ./ (result(:,13) + result(:,14));
dropRatioRAP = dropRatioRAP .* 100;

dropRatioRAP_Main = (result(:,10) + result(:,13)) ./ (result(:,10) + result(:,11) + result(:,13) + result(:,14));
dropRatioRAP_Main = dropRatioRAP_Main .* 100;

shareConfTraffic = result(:,16) ./ result(:,15);
shareConfTraffic = shareConfTraffic .* 100;

throughputRAP = result(:,17) ./ (simtime*1000*1000);
collisionsRAP = result(:,18);

throughputFTP = (result(:,19).*8) ./ (simtime*1000*1000);

throughputMRIn = result(:,20) ./ (1000*1000);
throughputMROut = result(:,21) ./ (1000*1000);

throughputCombinedMR = throughputMRIn+throughputMROut;

avgQueueLengthRAP = result(:,23);


%queueAvgWaitRemote = result2(:,1);
%queueAvgWaitMain = result2(:,2);
modResults = [lossRatiosProf'
              lossRatiosConf'
              dropRatioRemote'
              dropRatioMain'
              avgQueueLengthRemote'
              avgQueueLengthMain'
              dropRatioRAP'
              dropRatioRAP_Main'
              shareConfTraffic'
              throughputRAP'
              collisionsRAP'
              throughputFTP'
              throughputMRIn'
              throughputMROut'
              throughputCombinedMR'
              avgQueueLengthRAP']';

% calculate confidence intervals
[mean, e] = confIntervals( modResults, repititions, alpha);


resultArray = {'ProfessorsLaptop','packet loss ratio','%';
                'ConferenceLaptop','packet loss ratio','%';
                'RemoteRouter', 'drop ratio','%';
                'MainRouter', 'drop ratio','%';
                'RemoteRouter', 'avg queue length','# of packets';
                'MainRouter', 'avg queue length','# of packets';
                'RAP', 'drop ratio hl','%';
                'RAP + Main', 'drop ratio','%';
                'ConferenceLaptop', 'traffic share','bytes/s';
                'RAP', 'WRONG WRONG WRONG Throughput WRONG WRONG WRONG', 'Mbps';
                'RAP', '# of collisions', ' ';
                'FTPLaptop','Throughput', 'Mbps';
                'MainRouter', 'Throughput In', 'Mbps';
                'MainRouter', 'Throughput Out', 'Mbps';
                'MainRouter', 'Throughput Combined', 'Mbps'
                'RAP', 'Average Queue Length', '# of packets'};
            
%plot each row of mean and confidence intervals
% A row corresponds to the row in the search array
for i=1:size(mean, 1)
    title = strcat(resultArray{i,1},' - ', resultArray{i,2});
    yunit = resultArray{i,3};
    plotConf(imageDirectory, title, x, mean(i,:), e(i,:), '# of clients', yunit);
end

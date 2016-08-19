% This script calculates the confidence intervals for the lateRatios of the
% voip/video streams of the profesors and conference laptops and plots them

simtime = 500;
repititions = 10;
alpha = 0.05;
%Prepend folder for result set
imageDirectory = 'images/trial1/';
%The amount of clients
x = [1,5, 10,20,40,60,80];


% fileBase contains the path to result data file up to the run number
fileBase = '../results/trial1-cctv-160818/ExamTaskNetwork-'
% fileStartNr denotes the first run number
fileStartNr = 0;
% fileEndNr denotes the last run number
fileEndNr = 69;
% the search array contains the modulename and parameter name to look at
% the data is extracted for each row
searchArray = {'ExamTaskNetwork.ProfessorsLaptop.udpApp[0]','"packets sent"';
    'ExamTaskNetwork.ProfessorsLaptop.udpApp[0]','"packets received"';
    'ExamTaskNetwork.ProfessorsLaptop.udpApp[0]','"discarded packets"';
    'ExamTaskNetwork.ConferenceLaptop.udpApp[0]','"packets sent"';
    'ExamTaskNetwork.ConferenceLaptop.udpApp[0]','"packets received"';
    'ExamTaskNetwork.ConferenceLaptop.udpApp[0]','"discarded packets"';
    'ExamTaskNetwork.RemoteRouter.ppp[0].queue','dropPk:count';
    'ExamTaskNetwork.RemoteRouter.ppp[0].queue','rcvdPk:count';
    'ExamTaskNetwork.RemoteRouter.ppp[0].queue','queueLength:timeavg';
    'ExamTaskNetwork.MainRouter.ppp[0].queue','dropPk:count';
    'ExamTaskNetwork.MainRouter.ppp[0].queue','rcvdPk:count';
    'ExamTaskNetwork.MainRouter.ppp[0].queue','queueLength:timeavg';
    'ExamTaskNetwork.RemoteAccessPoint.wlan[0].mgmt','dropPkByQueue:count';
    'ExamTaskNetwork.RemoteAccessPoint.wlan[0].mac','rcvdPkFromHL:count';
    'ExamTaskNetwork.Internet.eth[0].mac', 'txPk:sum(packetBytes)';
    'ExamTaskNetwork.ProfessorsLaptop.eth[0].mac','txPk:sum(packetBytes)'}


[ result ] = extractDataSca( fileBase, fileStartNr, fileEndNr, searchArray );
searchArray2 = {'ExamTaskNetwork.MainRouter.ppp[0].queue','queueingTime:histogram', 'mean';
    'ExamTaskNetwork.RemoteRouter.ppp[0].queue','queueingTime:histogram', 'mean'}
%[ result2 ] = extractDataHist( fileBase, fileStartNr, fileEndNr, searchArray2 );

searchArray3 = {'ExamTaskNetwork.BrowsingLaptop','tcpApp[0]', 'rcvdPk:sum(packetBytes)';
    'ExamTaskNetwork.BrowsingLaptop','tcpApp[0]','sentPk:sum(packetBytes)'}
[ result3 ] = extractDataMulti( fileBase, fileStartNr, fileEndNr, searchArray3);
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


throughputRcvdBrowser = result3(:,1) ./ simtime;
throughputSendBrowser = result3(:,2) ./ simtime;
%queueAvgWaitRemote = result2(:,1);
%queueAvgWaitMain = result2(:,2);
modResults = [lossRatiosProf lossRatiosConf dropRatioRemote dropRatioMain avgQueueLengthRemote avgQueueLengthMain dropRatioRAP dropRatioRAP_Main shareConfTraffic throughputSendBrowser throughputRcvdBrowser];


repititions = 10;
alpha = 0.05;
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
                'Browser', 'send throughput all','bytes/s';
                'Browser', 'rcvd throughput all','bytes/s'}
            
%plot each row of mean and confidence intervals
% A row corresponds to the row in the search array
for i=1:size(mean, 1)
    title = strcat(resultArray{i,1},' - ', resultArray{i,2});
    yunit = resultArray{i,3};
    plotConf(imageDirectory, title, x, mean(i,:), e(i,:), '# of clients', yunit);
end

% This script calculates the confidence intervals for the lateRatios of the
% voip/video streams of the profesors and conference laptops and plots them

simtime = 1000;
%repititions = 15;
repititions = 15;
alpha = 0.05;
%Prepend folder for result set
imageDirectory = 'images/tst/';
%The amount of clients
x = [1,5,10,15,20,30,40,50,60];
%x = [1,5];


% fileBase contains the path to result data file up to the run number
fileBase = '../results/final2-cctv-160821/ExamTaskNetwork-'

% fileStartNr denotes the first run number
fileStartNr = 0;
% fileEndNr denotes the last run number
fileEndNr = 134;
%fileEndNr = 29;
% the search array contains the modulename and parameter name to look at
% the data is extracted for each row
searchArray = {'ProfessorsLaptop.udpApp[0]','"packets sent"';
    'ProfessorsLaptop.udpApp[0]','"packets received"';
    'ProfessorsLaptop.udpApp[0]','"discarded packets"';
    'ConferenceLaptop.udpApp[0]','"packets sent"';
    'ConferenceLaptop.udpApp[0]','"packets received"';
    'ConferenceLaptop.udpApp[0]','"discarded packets"';
    %'RemoteRouter.ppp[0].queue','dropPk:count';
    %'RemoteRouter.ppp[0].queue','rcvdPk:count';
    %'RemoteRouter.ppp[0].queue','queueLength:timeavg';
    %'MainRouter.ppp[0].queue','dropPk:count';
    %'MainRouter.ppp[0].queue','rcvdPk:count';
    %'MainRouter.ppp[0].queue','queueLength:timeavg';
    %'RemoteAccessPoint.wlan[0].mgmt','dropPkByQueue:count';
    %'RemoteAccessPoint.wlan[0].mac','rcvdPkFromHL:count';
    'Internet.eth[0].mac', 'txPk:sum(packetBytes)';
    'ProfessorsLaptop.eth[0].mac','txPk:sum(packetBytes)';
    %'RemoteAccessPoint.wlan[0].mac','sent and received bits';
    %'RemoteAccessPoint.wlan[0].mac','number of collisions';
    'Internet.tcpApp[1]', 'rcvdPk:sum(packetBytes)';
    'Internet.tcpApp[0]', 'sentPk:sum(packetBytes)';
    %'MainRouter.ppp[0].inputHook[0]', 'avg throughput (bit/s)'
    %'MainRouter.ppp[0].outputHook[0]', 'avg throughput (bit/s)';
    'CCTVCamera.udpApp[0]','"packets sent"';
    'CCTVMonitoring.udpApp[0]','"packets received"';
    'CCTVMonitoring.udpApp[0]','"discarded packets"';
    }


[ result ] = extractDataSca( fileBase, fileStartNr, fileEndNr, searchArray );

% calculate browser throughput stats
%searchArray = {'tcpApp[0]', 'rcvdPk:sum(packetBytes)';
%    'tcpApp[0]','sentPk:sum(packetBytes)';
%    'tcpApp[0]','numActiveSessions:timeavg';
%    'tcpApp[0]','numSessions:last'};
%module = 'BrowsingLaptop';
searchArray = {'BrowsingLaptop','tcpApp[0]', 'rcvdPk:sum(packetBytes)';
    'BrowsingLaptop','tcpApp[0]','sentPk:sum(packetBytes)';
    'BrowsingLaptop','tcpApp[0]','numActiveSessions:timeavg';
    'BrowsingLaptop','tcpApp[0]','numSessions:last';
    }
[ result2 ] = extractDataMulti( fileBase, fileStartNr, fileEndNr, searchArray);




lossRatiosProf = (result(:,4) - (result(:,2)-result(:,3))) ./(result(:,4));
lossRatiosConf = (result(:,1) - (result(:,5)-result(:,6))) ./(result(:,1));
lossRatiosProf = lossRatiosProf .* 100;
lossRatiosConf = lossRatiosConf .* 100;
lossRatiosCamera = (result(:,11) - (result(:,12)-result(:,13))) ./(result(:,11));
lossRatiosCamera = lossRatiosCamera .* 100;
%dropRatioRemote = result(:,7) ./ (result(:,7) + result(:,8));
%dropRatioMain = result(:,10) ./ (result(:,10) + result(:,11));
%dropRatioRemote = dropRatioRemote .* 100;
%dropRatioMain = dropRatioMain .* 100;

%avgQueueLengthRemote = result(:,9);
%avgQueueLengthMain = result(:,12);
%dropRatioRAP = result(:,13) ./ (result(:,13) + result(:,14));
%dropRatioRAP = dropRatioRAP .* 100;

%dropRatioRAP_Main = (result(:,10) + result(:,13)) ./ (result(:,10) + result(:,11) + result(:,13) + result(:,14));
%dropRatioRAP_Main = dropRatioRAP_Main .* 100;

shareConfTraffic = result(:,8) ./ result(:,7);
shareConfTraffic = shareConfTraffic .* 100;

%throughputRAP = result(:,17) ./ (simtime*1000*1000);
%collisionsRAP = result(:,18);

throughputFTP = (result(:,9).*8) ./ (simtime*1000*1000);
throughputBrowser = (result(:,10).*8) ./ (simtime*1000*1000);
sessionavgtime = result2(:,3);
%throughputRcvdBrowserAll = (result2(:,1) .* 8 ./ (result2(:,3) .* simtime)) ./ (1000*1000);
%throughputSendBrowserAll = (result2(:,2) .* 8 ./ (result2(:,3) .* simtime)) ./ (1000*1000);

%avgSessionLengthBrowser = (result2(:,3) .* simtime) ./ result2(:,4)

%throughputMRIn = result(:,20) ./ (1000*1000);
%throughputMROut = result(:,21) ./ (1000*1000);

%throughputCombinedMR = throughputMRIn+throughputMROut;

%queueAvgWaitRemote = result2(:,1);
%queueAvgWaitMain = result2(:,2);
modResults = [
              %lossRatiosProf'
              %lossRatiosConf'
              %dropRatioRemote'
              %dropRatioMain'
              %avgQueueLengthRemote'
              %avgQueueLengthMain'
              %dropRatioRAP'
              %dropRatioRAP_Main'
              %shareConfTraffic'
              %throughputRAP'
              %collisionsRAP'
              throughputFTP'
              %throughputMRIn'
              %throughputMROut'
              %throughputCombinedMR'
              throughputBrowser'
              sessionavgtime'
              lossRatiosProf'
              lossRatiosConf'
              lossRatiosCamera'
              ]';

% calculate confidence intervals
[mean, e] = confIntervals( modResults, repititions, alpha);

meanR1 = [mean(1:2,:); (mean(2,:) ./ x)];
eR1 = [e(1:2,:); (e(2,:) ./ x)];
meanR1 = [meanR1; (mean(2,:) ./ x) .*  (x ./ mean(3,:))];
eR1 = [eR1; (e(2,:) ./ x) .*  (x ./ e(3,:))];

meanR2 = mean(4:6,:);
eR2 = e(4:6,:);
resultArray = {'ProfessorsLaptop','packet loss ratio','%';
                'ConferenceLaptop','packet loss ratio','%';
                'RemoteRouter', 'drop ratio','%';
                'MainRouter', 'drop ratio','%';
                'RemoteRouter', 'avg queue length','# of packets';
                'MainRouter', 'avg queue length','# of packets';
                'RAP', 'drop ratio hl','%';
                'RAP + Main', 'drop ratio','%';
                'ConferenceLaptop', 'traffic share','bytes/s';
                'RAP', 'Throughput', 'Mbps';
                'RAP', '# of collisions', ' ';
                'FTPLaptop','Throughput', 'Mbps';
                'MainRouter', 'Throughput In', 'Mbps';
                'MainRouter', 'Throughput Out', 'Mbps';
                'MainRouter', 'Throughput Combined', 'Mbps'};
            
param = 'Application Throughputs';
xlab = '# of clients';
ylab = 'Mbps';
l = {'FTP Throughput', 'Combined HTTP Throughput', 'Single HTTP Throughput', 'Adjusted HTTP Throughput'};
%combPlotConf(imageDirectory, title, x, meanR, eR, '# of clients', yunit, legend);         
figure('Name',param)
hold on;
%bar(x, mean,'facecolor',[.8 .8 .8]); ylabel(ylab); xlabel(xlab);
errorbar(x,meanR1(1,:),eR1(1,:),'LineWidth',2);
errorbar(x,meanR1(2,:),eR1(2,:),'LineWidth',2);
plot(x,meanR1(3,:),'LineWidth',2);
plot(x,meanR1(4,:),'LineWidth',2);
ylabel(ylab);
xlabel(xlab);
legend(l);
title(param);
if ~exist(imageDirectory,'dir')
    mkdir(imageDirectory);
end
print(strcat(imageDirectory,param), '-dpng');

param = 'Single HTTP Request Throughputs';
xlab = '# of clients';
ylab = 'Mbps';
l = {'HTTP Throughput', 'Adjusted HTTP Throughput'};
%combPlotConf(imageDirectory, title, x, meanR, eR, '# of clients', yunit, legend);         
figure('Name',param)
hold on;
%bar(x, mean,'facecolor',[.8 .8 .8]); ylabel(ylab); xlabel(xlab);
plot(x,meanR1(3,:),'LineWidth',2);
plot(x,meanR1(4,:),'LineWidth',2);
ylabel(ylab);
xlabel(xlab);
legend(l);
title(param);
if ~exist(imageDirectory,'dir')
    mkdir(imageDirectory);
end
print(strcat(imageDirectory,param), '-dpng');

param = 'Application Packet Loss Rates';
xlab = '# of clients';
ylab = '%';
l = {'Professors Laptop ', 'Conference Laptop', 'CCTV Monitor'};
%combPlotConf(imageDirectory, title, x, meanR, eR, '# of clients', yunit, legend);         
figure('Name',param)
hold on;
%bar(x, mean,'facecolor',[.8 .8 .8]); ylabel(ylab); xlabel(xlab);
errorbar(x,meanR2(1,:),eR2(1,:),'LineWidth',2);
errorbar(x,meanR2(2,:),eR2(2,:),'LineWidth',2);
errorbar(x,meanR2(3,:),eR2(2,:),'LineWidth',2);
ylabel(ylab);
xlabel(xlab);
legend(l, 'Location','northwest');
title(param);
if ~exist(imageDirectory,'dir')
    mkdir(imageDirectory);
end
print(strcat(imageDirectory,param), '-dpng');
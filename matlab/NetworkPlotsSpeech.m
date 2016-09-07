% This script calculates the confidence intervals for the lateRatios of the
% voip/video streams of the profesors and conference laptops and plots them

simtime = 1000;
%repititions = 15;
repititions = 15;
alpha = 0.05;
%Prepend folder for result set
%Prepend folder for result set
imageDirectory = 'images/speechcctv/';
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
searchArray = {%'ProfessorsLaptop.udpApp[0]','"packets sent"';
    %'ProfessorsLaptop.udpApp[0]','"packets received"';
    %'ProfessorsLaptop.udpApp[0]','"discarded packets"';
    %'ConferenceLaptop.udpApp[0]','"packets sent"';
    %'ConferenceLaptop.udpApp[0]','"packets received"';
    %'ConferenceLaptop.udpApp[0]','"discarded packets"';
    'RemoteRouter.ppp[0].queue','dropPk:count';
    'RemoteRouter.ppp[0].queue','rcvdPk:count';
    'RemoteRouter.ppp[0].queue','queueLength:timeavg';
    'MainRouter.ppp[0].queue','dropPk:count';
    'MainRouter.ppp[0].queue','rcvdPk:count';
    'MainRouter.ppp[0].queue','queueLength:timeavg';
    'RemoteAccessPoint.wlan[0].mgmt','dropPkByQueue:count';
    'RemoteAccessPoint.wlan[0].mac','rcvdPkFromHL:count';
    'FTPLaptop.wlan[0].mgmt','dropPkByQueue:count';
    'FTPLaptop.wlan[0].mac','rcvdPkFromHL:count';
    'ConferenceLaptop.wlan[0].mgmt','dropPkByQueue:count';
    'ConferenceLaptop.wlan[0].mac','rcvdPkFromHL:count';
    %'Internet.eth[0].mac', 'txPk:sum(packetBytes)';
    %'ProfessorsLaptop.eth[0].mac','txPk:sum(packetBytes)';
    'RemoteAccessPoint.wlan[0].mac','sent and received bits';
    'RemoteAccessPoint.wlan[0].mac','number of collisions';
    %'Internet.tcpApp[1]', 'rcvdPk:sum(packetBytes)';
    %'Internet.tcpApp[0]', 'sentPk:sum(packetBytes)';
    'MainRouter.ppp[0].inputHook[0]', 'avg throughput (bit/s)'
    'MainRouter.ppp[0].outputHook[0]', 'avg throughput (bit/s)';
    %'RemoteAccessPoint.wlan[0].mac','rcvdPkFromLL:sum(packetBytes)';
    %'RemoteAccessPoint.wlan[0].mac','sentDownPk:sum(packetBytes)';
    'RemoteAccessPoint.wlan[0].mac','passedUpPk:sum(packetBytes)';
    'RemoteAccessPoint.wlan[0].mac','rcvdPkFromHL:sum(packetBytes)';
    %'CCTVCamera.udpApp[0]','"packets sent"';
    %'CCTVMonitoring.udpApp[0]','"packets received"';
    %'CCTVMonitoring.udpApp[0]','"discarded packets"';
    'RemoteAccessPoint.wlan[0].mgmt','dataQueueLen:timeavg';
    'ConferenceLaptop.wlan[0].mgmt','dataQueueLen:timeavg';
    'FTPLaptop.wlan[0].mgmt','dataQueueLen:timeavg';
   
    }


%[ result ] = extractDataSca( fileBase, fileStartNr, fileEndNr, searchArray );

searchArray = {'BrowsingLaptop','wlan[0].mgmt', 'dropPkByQueue:count';
    'BrowsingLaptop','wlan[0].mac','rcvdPkFromHL:count';
    'BrowsingLaptop','wlan[0].mgmt', 'dataQueueLen:timeavg';
    }
%[ result2 ] = extractDataMulti( fileBase, fileStartNr, fileEndNr, searchArray);



%lossRatiosProf = (result(:,4) - (result(:,2)-result(:,3))) ./(result(:,4));
%lossRatiosConf = (result(:,1) - (result(:,5)-result(:,6))) ./(result(:,1));
%lossRatiosProf = lossRatiosProf .* 100;
%lossRatiosConf = lossRatiosConf .* 100;
%lossRatiosCamera = (result(:,11) - (result(:,12)-result(:,13))) ./(result(:,11));
%lossRatiosCamera = lossRatiosCamera .* 100;
dropRatioRemote = result(:,1) ./ (result(:,1) + result(:,2));
dropRatioMain = result(:,4) ./ (result(:,4) + result(:,5));
dropRatioRemote = dropRatioRemote .* 100;
dropRatioMain = dropRatioMain .* 100;

%avgQueueLengthRemote = result(:,9);
%avgQueueLengthMain = result(:,12);
droppedPacketsWLAN = result(:,7)+ result(:,9) + result(:,11) + result2(:,1);
rcvdPacketsWLAN = result(:,8)+ result(:,10) + result(:,12) + result2(:,2);
%dropRatioRAP = result(:,13) ./ (result(:,13) + result(:,14));
%dropRatioRAP = dropRatioRAP .* 100;
dropRatioWLAN = droppedPacketsWLAN ./ (droppedPacketsWLAN+rcvdPacketsWLAN);
dropRatioWLAN = dropRatioWLAN .* 100;
%dropRatioRAP_Main = (result(:,10) + result(:,13)) ./ (result(:,10) + result(:,11) + result(:,13) + result(:,14));
%dropRatioRAP_Main = dropRatioRAP_Main .* 100;

%shareConfTraffic = result(:,8) ./ result(:,7);
%shareConfTraffic = shareConfTraffic .* 100;

%throughputRAP = result(:,17) ./ (simtime*1000*1000);
%collisionsRAP = result(:,18);

%throughputFTP = (result(:,9).*8) ./ (simtime*1000*1000);
%throughputBrowser = (result(:,10).*8) ./ (simtime*1000*1000);
%sessionavgtime = result2(:,3);
%throughputRcvdBrowserAll = (result2(:,1) .* 8 ./ (result2(:,3) .* simtime)) ./ (1000*1000);
%throughputSendBrowserAll = (result2(:,2) .* 8 ./ (result2(:,3) .* simtime)) ./ (1000*1000);

%avgSessionLengthBrowser = (result2(:,3) .* simtime) ./ result2(:,4)

throughputMRIn = result(:,15) ./ (1000*1000);
throughputMROut = result(:,16) ./ (1000*1000);

throughputCombinedMR = throughputMRIn+throughputMROut;

throughputRAPIn = (result(:,17) .* 8) ./ (1000*1000*simtime);
throughputRAPOut = (result(:,18) .* 8) ./ (1000*1000*simtime);
throughputRAPCombined = throughputRAPIn+throughputRAPOut;

queueLengthAvgRAP = result(:,19);
queueLengthAvgConf = result(:,20);
queueLengthAvgFTP = result(:,21);
queueLengthAvgBrowser = result2(:,3);

queueLengthRR = result(:,3);
queueLengthMR = result(:,6);


%queueAvgWaitRemote = result2(:,1);
%queueAvgWaitMain = result2(:,2);
modResults = [
              dropRatioRemote'
              dropRatioMain'
              dropRatioWLAN'
              throughputMRIn'
              throughputMROut'
              throughputCombinedMR'
              throughputRAPIn'
              throughputRAPOut'
              throughputRAPCombined'
              queueLengthAvgRAP'
              queueLengthAvgConf'
              queueLengthAvgFTP'
              queueLengthRR'
              queueLengthMR'
              queueLengthAvgBrowser'
              %avgQueueLengthRemote'
              %avgQueueLengthMain'
              %dropRatioRAP'
              %dropRatioRAP_Main'
              %shareConfTraffic'
              %throughputRAP'
              %collisionsRAP'   
              %throughputMRIn'
              %throughputMROut'
              %throughputCombinedMR'
              %throughputBrowser'
              %sessionavgtime'
              %lossRatiosProf'
              %lossRatiosConf'
              %lossRatiosCamera'
              ]';

titleSize = 20;
% calculate confidence intervals
[mean, e] = confIntervals( modResults, repititions, alpha);

meanR1 = mean(1:3,:);
eR1 = e(1:3,:);
            
param = 'Network Packet Drop Rates';
xlab = '# of clients';
ylab = '%';
l = {'Remote Router', 'Main Router', 'WLAN'};
%combPlotConf(imageDirectory, title, x, meanR, eR, '# of clients', yunit, legend);         
figure('Name',param)
hold on;
%bar(x, mean,'facecolor',[.8 .8 .8]); ylabel(ylab); xlabel(xlab);
errorbar(x,meanR1(1,:),eR1(1,:),'LineWidth',1);
errorbar(x,meanR1(2,:),eR1(2,:),'LineWidth',1);
errorbar(x,meanR1(3,:),eR1(3,:),'LineWidth',1);
ylabel(ylab);
xlabel(xlab);
legend(l);
title(param,'FontSize', titleSize);
if ~exist(imageDirectory,'dir')
    mkdir(imageDirectory);
end
print(strcat(imageDirectory,param), '-dpng');

meanR2 = [mean(4:6,:);mean(7:9,:)];
eR2 = [e(4:6,:);e(7:9,:)];

param = 'Network Throughputs';
xlab = '# of clients';
ylab = 'Mbps';
l = {'To Main Campus', 'To Remote Campus', 'WLAN', 'Radio Link'};
%combPlotConf(imageDirectory, title, x, meanR, eR, '# of clients', yunit, legend);         
figure('Name',param)
hold on;
%bar(x, mean,'facecolor',[.8 .8 .8]); ylabel(ylab); xlabel(xlab);
errorbar(x,meanR2(1,:),eR2(1,:),'LineWidth',1);
errorbar(x,meanR2(2,:),eR2(2,:),'LineWidth',1);
errorbar(x,meanR2(6,:),eR2(6,:),'LineWidth',1);
errorbar(x,meanR2(3,:),eR2(3,:),'LineWidth',1);

ylabel(ylab);
xlabel(xlab);
legend(l, 'Location','southeast');
title(param,'FontSize', titleSize);
if ~exist(imageDirectory,'dir')
    mkdir(imageDirectory);
end
print(strcat(imageDirectory,param), '-dpng');


meanR2 = mean(10:14,:);
eR2 = e(10:14,:);
%meanR2 = [meanR2; mean(15,:) ./ x];
%eR2 = [eR2; (e(15,:) ./ x)];
meanR2 = [meanR2; mean(15,:)];
eR2 = [eR2; e(15,:)];
param = 'Average Queue Lengths';
xlab = '# of clients';
ylab = '# of packets';
l = {'Remote Router', 'Main Router','Access Point', 'Conference Laptop', 'FTP Laptop'};
%combPlotConf(imageDirectory, title, x, meanR, eR, '# of clients', yunit, legend);         
figure('Name',param)
hold on;
%bar(x, mean,'facecolor',[.8 .8 .8]); ylabel(ylab); xlabel(xlab);
errorbar(x,meanR2(4,:),eR2(4,:),'LineWidth',1);
errorbar(x,meanR2(5,:),eR2(5,:),'LineWidth',1);
errorbar(x,meanR2(1,:),eR2(1,:),'LineWidth',1);
errorbar(x,meanR2(2,:),eR2(2,:),'LineWidth',1);
errorbar(x,meanR2(3,:),eR2(3,:),'LineWidth',1);
ylabel(ylab);
xlabel(xlab);
legend(l, 'Location','northwest');
title(param,'FontSize', titleSize);
if ~exist(imageDirectory,'dir')
    mkdir(imageDirectory);
end
print(strcat(imageDirectory,param), '-dpng');
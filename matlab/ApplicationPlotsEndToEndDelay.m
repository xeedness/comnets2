% This script calculates the confidence intervals for the lateRatios of the
% voip/video streams of the profesors and conference laptops and plots them

simtime = 1000;
%repititions = 15;
repititions = 15;
alpha = 0.05;
%Prepend folder for result set
imageDirectory = 'images/finalnocctv/';
%The amount of clients
x = [1,5,10,15,20,30,40,50,60];
%x = [1,5];


% fileBase contains the path to result data file up to the run number
fileBase = '../results/final2-nocctv-160821/ExamTaskNetwork_no_CCTV-'

% fileStartNr denotes the first run number
fileStartNr = 0;
% fileEndNr denotes the last run number
fileEndNr = 134;
%fileEndNr = 29;
% the search array contains the modulename and parameter name to look at
% the data is extracted for each row
searchArray = {'ConferenceLaptop.udpApp[0]','endToEndDelay:stats', 'mean';
    'ProfessorsLaptop.udpApp[0]','endToEndDelay:stats', 'mean'};
    %'CCTVMonitoring.udpApp[0]','endToEndDelay:stats', 'mean'}
[ result3 ] = extractDataHist( fileBase, fileStartNr, fileEndNr, searchArray );

avgDelayConf = result3(:,1);
avgDelayProf = result3(:,2);
%avgDelayCCTV = result3(:,3);
avgDelayConf = avgDelayConf .* 1000;
avgDelayProf = avgDelayProf .* 1000;
%avgDelayCCTV = avgDelayCCTV .* 1000;
modResults = [
              avgDelayConf'
              avgDelayProf'
              %avgDelayCCTV' 
              ]';

% calculate confidence intervals
[mean, e] = confIntervals( modResults, repititions, alpha);

param = 'Application Packet Delays';
xlab = '# of clients';
ylab = 'ms';
l = {'Conference Laptop', 'Professors Laptop'}; %, 'CCTV Monitoring'};
figure('Name',param)
hold on;
errorbar(x,mean(1,:),e(1,:),'LineWidth',2);
errorbar(x,mean(2,:),e(2,:),'LineWidth',2);
%errorbar(x,mean(3,:),e(3,:),'LineWidth',2);
ylabel(ylab);
xlabel(xlab);
legend(l,'Location','northwest');
%title(param);
if ~exist(imageDirectory,'dir')
    mkdir(imageDirectory);
end
print(strcat(imageDirectory,param), '-dpng');

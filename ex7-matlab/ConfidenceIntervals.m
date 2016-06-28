[mean, e] = Conf('CurrentNetwork-0_isdn.sca');
hold off; bar(mean,'facecolor',[.8 .8 .8]); ylabel('kbps'); hold on;
errorbar(mean,e,'LineWidth',2);



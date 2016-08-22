function [ output_args ] = combPlotConf(dir, param, x,  mean, e, xlab, ylab, l)
    figure('Name',param)
    hold off;
    %bar(x, mean,'facecolor',[.8 .8 .8]); ylabel(ylab); xlabel(xlab);
    hold on;
    for i=1:size(mean, 1)
        errorbar(x,mean(i,:),e(i,:),'LineWidth',2);
    end
    ylabel(ylab);
    xlabel(xlab);
    legend(l);
    title(param);
    if ~exist(dir,'dir')
        mkdir(dir);
    end
    print(strcat(dir,param), '-dpng');
end


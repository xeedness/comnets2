function [ output_args ] = plotConf(dir, param, x,  mean, e, xlab, ylab  )
    figure('Name',param)
    hold off; bar(mean,'facecolor',[.8 .8 .8]); ylabel(ylab); xlabel(xlab); hold on;
    errorbar(mean,e,'LineWidth',2);
    title(param)
    if ~exist(dir,'dir')
        mkdir(dir)
    end
    print(strcat(dir,param), '-dpng')
end


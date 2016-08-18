function [ output_args ] = plotConf(param, mean, e, xlab, ylab  )
    figure('Name',param)
    hold off; bar(mean,'facecolor',[.8 .8 .8]); ylabel(ylab); xlabel(xlab); hold on;
    errorbar(mean,e,'LineWidth',2);
end


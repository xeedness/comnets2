function [ fits, ratio ] = poissonChi2Test( samples, binSize,alpha )
    
    dof = 1;
    
    
    %generate histogram with widths
    tst = [0:1:max(samples)+1];
    h = histogram(samples,100)
    sampleHist = h.Values;
    sampleWidths = h.BinEdges;
    %bar(sampleHist)
    %hold on;   

    n = 1;
    maxN = length(sampleHist);
    %adjust buckets
    while n <= maxN-1
       if(sampleHist(n) <= binSize)
           sampleHist(n+1) = sampleHist(n+1) + sampleHist(n);
           sampleHist(n) = [];
           sampleWidths(n) = [];
       else
           n = n +1;
       end

       maxN = length(sampleHist);
    end

    n = length(sampleHist)

    while n >= 2
       if(sampleHist(n) <= binSize)
           sampleHist(n-1) = sampleHist(n-1) + sampleHist(n);
           sampleWidths(n-1) = sampleWidths(n);
           sampleHist(n) = [];
           sampleWidths(n) = [];
       end
       n = n -1;

    end

    sampleHist;
    sampleWidths;
    %bar(sampleHist, sampleWidths);
    %hold on;

    pExponential = fitdist(samples, 'Exponential');
    pPoisson = fitdist(samples, 'Poisson');
    x = 0:500:max(samples);
    y = exppdf(x, pExponential.mu);
    %y = poisspdf(x, 1/pPoisson.lambda);
    plot(x,y,'+')

    [hExp, pExp, statsExp] = chi2gof(samples, 'Edges', sampleWidths, 'CDF', pExponential, 'Alpha', alpha)
    [hPois, pPois, statsPois] = chi2gof(samples, 'Edges', sampleWidths, 'CDF', pPoisson, 'Alpha', alpha)

    %hPois
    %hExp

    %pPois
    %pExp

    %fits = chi2query <= chi2level;
    %ratio = chi2ratio;

end


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


    %fprintf('Adjusted Histogram:\n');
    sampleHist;
    sampleWidths;
    %bar(sampleHist, sampleWidths);
    %hold on;

    %generate expected values
    %{
        lambdasample = 0;
        for n=1:length(samples)
           lambdasample = lambdasample + samples(n);
        end

        lambdasample = lambdasample/length(samples);


        P = 0
        for n = 1:length(sampleWidths)
            if(n == 1)
                P(n) = poisscdf(sampleWidths(n),lambdasample);
            else
                P(n) = poisscdf(sampleWidths(n),lambdasample) - poisscdf(sampleWidths(n-1),lambdasample);
            end
        end

        NP = P.*length(samples)
        bar(P);

        chi2query = 0;
        for n = 1:length(P)
            sub = sampleHist(n)-NP(n);
            chi2query = (sub*sub) / NP(n);
        end

        chi2level = chi2inv(1-alpha, length(sampleHist)-dof-1);
        chi2ratio = chi2query/chi2level;
        fprintf('Chi2Sum: %.02f\n',chi2query);
        fprintf('Chi2Level: %.02f\n', chi2level);
        fprintf('Chi2Ratio: %.05f\n', chi2ratio);
    %}
    
    
    
    

    pExponential = fitdist(samples, 'Exponential');
    pPoisson = fitdist(samples, 'Poisson');
    x = 0:500:max(samples);
    y = exppdf(x, pExponential.mu);
    %y = poisspdf(x, 1/pPoisson.lambda);
    plot(x,y,'+')
    
    
    %sampleWidths(1) = []
    %sampleWidths(length(sampleWidths)) = []
    %for n = 1:length(sampleWidths)-1
    %   sampleWidths(n) = sampleWidths(n+1);
    %end
    %sampleWidths(1) = [];
    [hExp, pExp, statsExp] = chi2gof(samples, 'Edges', sampleWidths, 'CDF', pExponential, 'Alpha', alpha)
    [hPois, pPois, statsPois] = chi2gof(samples, 'Edges', sampleWidths, 'CDF', pPoisson, 'Alpha', alpha)
    %[hExp, pExp, statsExp] = chi2gof(samples, 'Edges', sampleWidths, 'CDF', pExponential, 'Alpha', alpha);
    
    hPois
    %hExp
    
    pPois
    %pExp
    
    %fits = chi2query <= chi2level;
    %ratio = chi2ratio;

end


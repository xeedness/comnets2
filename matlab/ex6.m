N = 1000;
lambda = 7;
alpha = 0.05;
%Uniform 0-1 random values
%uniforms = rand(N,1);
%Poisson
%samples = poissinv(uniforms, lambda);
samples = random('Poisson', lambda, 1, N);

[fits, ratio] = poissonChi2Test(samples, alpha)
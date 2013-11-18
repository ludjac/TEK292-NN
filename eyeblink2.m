% The function eyeblink2 takes input from mossy fibers, CS
% and from climbing fibres, US and computes the response.

function [P wP] = eyeblink2(CS,US)

T=length(CS);  % Number of time steps
ND = 10; % Number of nodes in the delay line

bias=-5;
E = .01;
delta=.1;

% Output from delay line nodes. Row i of the matrix D 
% represents the output from node i in the delay line.
D=zeros(ND,T);

% Output from neuron P

P=zeros(1,T);

% Fixed unitary weights of the delay line. The only purpose of 
% the delay line is to save previous input for access to the P neuron.

wD=ones(ND,T);


% Dynamic weights of the neuron P-

wP=2*ones(ND,T);

for t=ND+1:T
    D(1, t) = CS(t);
    
    D(2:ND,t) = D(1:ND-1,t-1);    
    % Compute the output from the network at time t
    P(t) = expit(wP(:,t)'*D(:,t) + bias);

    % update weights
    wP(:, t+1) = wP(:,t) + delta*US(t)*D(:, t) - E*(1 - US(t))*D(:, t);
   
end

plot([CS' US' P'])
axis([0 T -.1 1.1])
legend('CS','US','P')
xlabel('time')
ylabel('signal')

function p=expit(x) 
    p = 1./(1+exp(-x));



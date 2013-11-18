% The function eyeblink1 takes input from mossy fibers, CS
% and from climbing fibres, US in the form of 1xT matrices 
% and computes the sequence of  responses P of the network.

function [P, wP] = eyeblink1(CS,US, ex)

[N, T] =size(CS);

% output from neuron P
P=zeros(1,T);

% dynamic weights
wP=0*ones(N,T);

% for n=1:N

delta = 1;
E = 0.6;
bias = -5; 


for t=1:T
	% Compute the output from the network at time t
	P(t) = expit(wP(:,t)' * CS(:, t) + bias);
        
	% Inhibition (EX. 2)
	if ex >= 2
	    delta = (0.95 - P(t));
	    E     = (P(t) - 0.05);
	end
	
	% Update weights
	%for n=1:N
	% wP(t, :)
	wP(:, t+1) = wP(:, t) + delta*US(t)*CS(:, t) - E*(1 - US(t))*CS(:, t);
	%end
end

if ex == 3
    subplot(311)
    hold on
    plot(CS(1, :)', 'b-');
    plot(CS(2, :)', 'b-.');
    plot(US', 'g--');
    plot(P', 'r--');
    % plot([CS(1,:)' US' P(1,:)'], '--');
    legend('CS1', 'CS2', 'US', 'P')
    axis([0 T -.1 1.1])
    xlabel('time')
    ylabel('signal')
    hold off

    subplot(312)
    hold on
    plot(CS(1, :)', 'r--');
    plot(CS(2, :)', 'b-.');
 %   plot(US', 'g.');
 %   plot(P', 'r--');
 %   plot([CS(2,:)' US' P(2,:)'], '--');
    legend('CS1','CS2')
    axis([0 T -.1 1.1])
    xlabel('time')
    ylabel('signal')
    hold off

else
    hold on
    plot(CS', 'b-');
    plot(US', 'g--');
    plot(P', 'r--');
 %   plot([CS' US' P'], '--');
    legend('CS','US','P')
    axis([0 T -.1 1.1])
    xlabel('time')
    ylabel('signal')
    hold off
end 

function p = expit(x) 
    p=1./(1+exp(-x));
    

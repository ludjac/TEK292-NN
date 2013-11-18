%%%%%%%%%%%%%%%%%%%%%%% TEK292: LAB - Neural Networks %%%%%%%%%%%%%%%%%%%%%%%%%
%
% by: Ludwig Jacobsson | knd09lja | ludjac@gmail.com
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameters and keywords:
% P - Neuron
% Synaps - Neuron input, gain by CS and US 
% CS - Conditioned stimulus, synaps input, tone
% US - Unconditioned stimulus, synaps input, shock to the eye
% delta - CS gain constant
% E - US gain constant
% Inhibition - Prevents over-learning, keeps neuron weights reasonable 
% Mossy fibres - CS input, ex. sound & light
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% EX.1:  eyeblink1.m %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%% Q1: What are the effects of the weight and bias on the output? What mechanisms
%% of a real neuron do they represent?
%
% Weight: Current value for synapse responsivity. If weight is non zero from
% start we have a 'nervous'/'sensivite' synapse. It will react to any signal
% regardless of type, almost like a reflex.  
% BIAS:	Represents the sensitivity (how easy it is to change to signals) for the synapse.
%%%%%%%%%%%%%%
% Q2: How does the updating work? What happens when US = 1 and CS = 1, when US =
% 0 and CS =1, when US = 1 and CS = 0 and when US = CS= 0?
% 
% It rewards and punishes when a wanted/unwanted match occurs. 
%%%%%%%%%%%%%%
% Q3: What are the effects of delta and E on learning?
%
% delta is a conditioning coefficient (reward-coefficient) It determines how
% fast we learn.
% E is a unconditioning coefficient (punish-coefficient) it determines how fast
% we unlearn. 

%% 1.
CS 	= repmat([0 0 1], 1, 20);
US 	= repmat([0 0 1], 1, 20);

[P, wP] = eyeblink1(CS, US, 1);
%% 2. 
CS 	= [repmat([0 0 1], 1, 20) repmat([0 0 1], 1, 10) repmat([0 0 1], 1, 20)];
US 	= [repmat([0 0 1], 1, 20) zeros(1, 10) ones(1, 10) zeros(1, 10) repmat([0 0 1], 1, 20)];

eyeblink1(CS, US, 1);
%% 3.

CS 	= repmat([0 0 1],1,100);
US 	= [repmat([0 0 1],1,50) zeros(1, 150)];
T 	= length(CS);

subplot(211)
[P, wP] = eyeblink1(CS, US, 1);
title('Learning and unlearning')
subplot(212)
plot(wP)
axis([0 T -30 50])
grid on

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% EX.2 : Inhibition %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Q4: What is the difference in the behaviour of the network before and after the
% modification of the weight updating? Why?
% 
% BEFORE: Weight increase is linear
% AFTER: Weight increase is exponential TODO : exponential? 
% Delta and E is adjusted by the neuron output
%
%% 1.
figure(1)

CS 	= repmat([0 0 1],1,50);
US 	= [repmat([0 0 1],1,25) zeros(1, 75)];
T 	= length(CS);

subplot(221)
[P, wP] = eyeblink1(CS, US, 1);
title('Learning/unlearning no inhibition (overlearning)')
subplot(223)
plot(wP)
axis([0 T -30 50])
grid on

subplot(222)
[P, wP] = eyeblink1(CS, US, 2);
title('Learning/unlearning with inhibition')
subplot(224)
plot(wP)
axis([0 T -30 50])
grid on

%%%%%%%%%%%%%%%%%%%%%%%%%% EX.3 : Multiple inputs %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Q5: Can you see the blocking effect in the above scenario? How?
% 
% We train the neuron with signal1 then switch to both. The training of weights
% for signal2 are then blocked. When we remove signal1 we have to restart
% training. 

% Q6: Can you see the effect of over-expectation in the above scenario? How?
%
% After both weights are trained, the output from signal on both is
% overestimated. When one signal is removed we get a lower output than before
% the estimate.  

figure(2)
%% Ex1/2
% CS 	= repmat([0 0 0; 0 0 1],1,20);
% US 	= repmat([0 0 1],1,20);
% T 	= length(CS);
% Q5 - Blocking
US = repmat([0 0 1], 1, 60);
CS = [repmat([0 0 1; 0 0 0],1, 20) repmat([0 0 1; 0 0 1],1,20) repmat([0 0 0; 0 0 1],1 ,20) ]; 
T = length(CS);

[P, wP] = eyeblink1(CS, US, 3);
title('Multiple inputs - Blocking')
subplot(313)
hold on
plot(wP(1,:), '-r')
plot(wP(2,:), '--b')
legend('wP1', 'wP2')
axis([0 T -30 50])
grid on
hold off

figure(3)
% Q6 - Overestimation 
US = repmat([0 0 1], 1, 80);
CS = [repmat([0 0 1;0 0 0],1, 20) ...
	repmat([0 0 0;0 0 1],1,20) ...
	repmat([0 0 1;0 0 1],1,20) ...
	repmat([0 0 1; 0 0 0],1,20) ];
T = length(CS);

[P, wP] = eyeblink1(CS, US, 3);
title('Multiple-inputs - Overestimation')
subplot(313)
hold on
plot(wP(1,:), '-r')
plot(wP(2,:), '--b')
legend('wP1', 'wP2')
axis([0 T -30 50])
grid on
hold off

 
% subplot(214)
% axis([0 T -30 50])
% grid on
% 


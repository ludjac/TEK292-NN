%%%%%%%%%%%%%%%%%%%%%%% TEK292: LAB - Neural Networks %%%%%%%%%%%%%%%%%%%%%%%%%
%
%by: Ludwig Jacobsson | knd09lja | ludjac@gmail.com
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
% Climbing fibres - US input, ex. blow to the eye
% Blocking - learning from one signal prevents learning from another signal
% Over-estimate - Two separately conditioned signals combined generate an even
% stronger response
% Down-regulate - As a result of over-estimate the response to a single signal
% is weakend.  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Initiation commands %%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear
clc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% EX.4:  eyeblink2.m %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%%% 				Timing and Delays 
%
% Q7: Explain how and why the learning mechanism works.
% 
% When any of the delay signals matches the US signal, positive feedback is
% given and the weight for that delay is updated. We can clearly se from the
% plot that weight for delay = 3 (wP4) is increasing. This is because the delay
% from CS to US is 3 steps. The weight for delay = 9 (wP10) is also increased but a
% bit later in the iteration. This is becouse CS-delay = 9 corresponds to the
% next US in the signal.  
% 
% Q8: Can the network be trained to respond to a CS that occurs after the US?
% Motivate your answer.
% 
% We are only looking at old CS signals that correspond to the current US
% signal when we update the weight. We would have to change the Delay vector to
% contain forward values of the CS signal. It is not impossible to imagine this
% situation in real life where where one would probably learn to expect a tone after the
% blow if this happens repeateldy. 
%

CS=repmat([0 0 1 0 0 0],1,20);
US=repmat([0 0 0 0 0 1],1,20);
T = length(CS);
figure(1)
subplot(211)
[P wP] = eyeblink2(CS, US);


subplot(212)
hold on
%plot(wP)
plot(wP')
legend('wP1', 'wP2', 'wP3', 'wP4', 'wP5', 'wP6', 'wP7', 'wP8', 'wP9', 'wP10')
hold off

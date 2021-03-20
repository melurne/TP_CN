%---------- Exemple------------%
%Définissez le port du khepera à travers laquelle le ComId communique
%clear all
clc; clear all;

% COM6 à gauche --- COM7 à droite
%kh4Start('COM7'); %à faire une seule fois au démarrage du robot
posd=24000;
posg=24000;
% Valeurs par défaut : P=10, I=5, D=10;
% Pour P= 1; I= 0; D=0 % Le robot ne bouge pas
P = 100;
I = 0;
D = 50;
%hold on;
kh4ResetEncoders;

kh4ConfigurePID(P,I,D)

success=kh4SetPosition(posd,posg);

%prise de mesure
SamplingTime = 5; % temps de mesure en s
k=0;
tStart = tic;
T = toc(tStart); % demarrage chrono
load('SerialKhepera.mat','serialPort')
fopen(serialPort);
while T< SamplingTime
    % t actuel
    k=k+1;
    
[lm(k), rm(k)] = kh4ReadEncoders;
 T = toc(tStart); %mesure chrono actuel
 time(k)=T
end
success=kh4SetSpeed(0,0);

fclose(serialPort);
%%%fclose(serialPort);

%graphes
close all;
subplot(1,2,1);
plot(time,posd*ones(size(time)),'--',time,lm,'r');
legend('Desired Position motor right','Position motor right')
xlabel('Time (s)')
ylabel('Encoders (pulses)')
title('P=100,D=50,I=0')
subplot(1,2,2);
plot(time,posg*ones(size(time)),'--',time,rm,'b');
legend('Desired Position motor left','Position motor left')
xlabel('Time (s)')
ylabel('Encoders (pulses)')
title('P=100,D=50,I=0')
%---------- Exemple------------%
%Définissez le port au travers duquel Matlab communique avec le khepera
%dans kh4Start (selon le port attribué par windows visible dans le
%gestionnaire de peripheriques)
clear all
clc
%kh4Start('COM6'); %à faire une seule fois au démarrage du robot
posg=100000;
posd=100000;

vitg=500;
vitd=500;

P = 10;
I = 5;
D = 1;

kh4ResetEncoders;

kh4ConfigurePID(P,I,D)
success=kh4SetPosition(posg,posd);

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


%graphes
close all
plot(time,lm);
hold on;
plot(time,rm,'r');

legend('Position motor left','Position motor right')
xlabel('Time (unit)')
ylabel('Encoders (pulses)')
title('title')

    
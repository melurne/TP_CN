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
I = 1;
D = 10;

kh4ResetEncoders;

kh4ConfigurePID(P,I,D)

%prise de mesure
SamplingTime = 9; % temps de mesure en s
k=0;
tStart = tic;
T = toc(tStart); % demarrage chrono
load('SerialKhepera.mat','serialPort')
fopen(serialPort);
success=kh4SetSpeed(vitg,vitd);
while T< 5
    % t actuel
    k=k+1;

[lspeed(k), rspeed(k)] = kh4ReadSpeed;
 T = toc(tStart); %mesure chrono actuel
 time(k)=T
end
success=kh4SetSpeed(0,0);
while T< 6
    % t actuel
    k=k+1;

[lspeed(k), rspeed(k)] = kh4ReadSpeed;
 T = toc(tStart); %mesure chrono actuel
 time(k)=T
end
success=kh4SetSpeed(vitg,-vitd);
while T< 9
    % t actuel
    k=k+1;

[lspeed(k), rspeed(k)] = kh4ReadSpeed;
 T = toc(tStart); %mesure chrono actuel
 time(k)=T
end
success=kh4SetSpeed(0,0);
fclose(serialPort);


%graphes
close all
subplot(1,3,1);
plot(time,vitg*ones(size(time)),'--',time,lspeed,'r');
legend('Desired Speed motor left','Speed motor left')
xlabel('Time (unit)')
ylabel('Speed (unit)')
title('P=10,D=10,I=1')
subplot(1,3,2);
plot(time,vitd*ones(size(time)),'--',time,rspeed,'b', time,0*ones(size(time)),'--', time,-vitd*ones(size(time)),'--');
legend('Desired Speed motor right','Speed motor right')

%plot(time,lspeed,'g');
%hold on;
%plot(time,rspeed,'c');

%legend('Speed motor left','Speed motor right')
xlabel('Time (unit)')
ylabel('Speed (unit)')
title('P=10,D=10,I=1')

subplot(1,3,3);
plot(time,vitg*ones(size(time)),'--',time,lspeed,'r');
legend('Desired Speed motor left','Speed motor left')
xlabel('Time (unit)')
ylabel('Speed (unit)')
title('P=10,D=10,I=1')

    
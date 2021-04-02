clc ; clear all

global  r1 f J m d I 

%Poids du robot
m = 0.08;
%Rayon du robot
R= 0.02;

f=3e-4;
J=1e-4;
%Distance qui sépare les deux roues et rayon des roux
d=0.04;
r1=0.01;
I=0.00588;

 %Matrices de la représentation d'état
 
 A=[0 0    0    0   ;
     0 0   0    0   ;
     0 0  -f/J  0   ;
     0 0   0   -f/J]; 
 
 B=[ 1/m      1/m     0     0   ;
     d/(2*I) -d/(2*I) 0     0   ;
    -R/J      0       1/J   0   ;
     0       -R/J     0     1/J];
 
 % [xpp; alphapp; theta1pp; theta2pp] = A*[xp; alphap; theta1p; theta2p]
 %                                      + B*[F1; F2; U1; U2]
 
 
 C=[0 0 1 0 ;
    0 0 0 1];
 D=zeros(2,4);
 
 % [theta1p; theta2p] = C*[xp; alphap; theta1p; theta2p] + D*[F1; F2; U1; U2]

clc; clear all, close all;



%lm_p10i05d10=lm; rm_p10i05d10=rm; time_p10i05d10=time;
load data_p100i50d0
load data_p100i50d1000
load data_p1000i0d0
load data_p1000i50d1000
%save data_p10i05d10 lm_p10i05d10 rm_p10i05d10 time_p10i05d10;

success=kh4SetSpeed(0,0);
%graphes
close all
time=time_p1000i50d1000;

plot(time_p100i50d0,lm_p100i50d0,'r',time_p100i50d1000,lm_p100i50d1000,'b',time_p1000i0d0,lm_p1000i0d0,'g',time_p1000i50d1000,lm_p1000i50d1000,'c');
legend('Position motor P=100/100 i=50/100 D=0/100','Position motor P=100/100 i=50/100 D=1000/100','Position motor P=10000/100 i=0/100 D=0/100','Position motor P=10000/100 i=50/100 D=1000/100')
xlabel('Time (s)')
ylabel('Encoders (pulses)')
title('Position de la roue gauche')
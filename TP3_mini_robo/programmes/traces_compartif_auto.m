
clc; clear all, close all;
n=4
pid1='p1000i500d100';
pid2='p1000i500d1000';
pid3='p5000i500d100';
pid4='p5000i1000d100';
pid5='p100i50d1000';
pid6='p100i50d1000';
pid7='p100i50d1000';
pid8='p100i50d1000';

color='bgrcmykw';
%lm_p10i05d10=lm; rm_p10i05d10=rm; time_p10i05d10=time;
com10='hold on; plot(';
com20='legend(';
com30='hold on; plot(';
com40='legend(';
for ii=1:n
    com=sprintf('pid=pid%d',ii); eval(com);
    com=sprintf('load data_%s;',pid); eval(com);
    
  if ii<n
    com1=sprintf('time_%s, lm_%s,''%s'',',pid, pid,color(ii));
    com2=sprintf('''%s'',',pid);
    com3=sprintf('time_%s, rm_%s,''%s'',',pid, pid,color(ii));
    com4=sprintf('''%s'',',pid);
  else
      com1=sprintf('time_%s, lm_%s,''%s'');',pid, pid,color(ii));
      com2=sprintf('''%s'');',pid);
      com3=sprintf('time_%s, rm_%s,''%s'');',pid, pid,color(ii));
      com4=sprintf('''%s'');',pid);
  end
      com10=strcat(com10,com1);
      com20=strcat(com20,com2);
      com30=strcat(com30,com3);
      com40=strcat(com40,com4);
end

close all
subplot(2,1,1);
eval(com10); eval(com20);
xlabel('Time (s)')
ylabel('Encoders (pulses)')
title('Position de la roue gauche')

subplot(2,1,2);
eval(com30); eval(com40);
xlabel('Time (s)')
ylabel('Encoders (pulses)')
title('Position de la roue droite')


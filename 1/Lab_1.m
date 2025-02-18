clc;
clear all;

% spec
Wp = 30000*2*pi;
Ws = 60000*2*pi;
Rp = 0.3;
Rs = 60;
Fs = 300000;
Ts = 1/Fs;

% change into butterworth spec 
Wp1 = Wp/Fs;
Ws1 = Ws/Fs;
Wp2 = (2/Ts)*tan(Wp1/2);
Ws2 = (2/Ts)*tan(Ws1/2);

% butterworth
[N,Wn] = buttord(Wp2,Ws2,Rp,Rs,'s');  % find order N and cutoff frequency
[Z,P,K] = buttap(N);                  % generate Nth order Butterworth filter's zeros, poles and gain
[Bap,Aap] = zp2tf(Z,P,K);             % transform zeros and poles into transfer funtion
[b,a] = lp2lp(Bap,Aap,Wn);            % move cutoff frequency to correct position by lp2lp
[bz,az] = bilinear(b,a,Fs);           % analog transfer function transforms into digital transfer function by bilinear method 
[H,W] = freqz(bz,az);                 % transform the transfer function into data of frequency to gain and data of frquency to phase

% frequency response plot
subplot(2,1,1);
plot(W*Fs/(2*pi),abs(H));
grid;
title('Frequency Response'); xlabel('Frequency(Hz)'); ylabel('Gain(v/v)');

% phase response plot
subplot(2,1,2);
plot(W*Fs/(2*pi),angle(H));
grid;
title('Phase Response'); xlabel('Frequency(Hz)'); ylabel('Phase(rad)');
clc;
clear all;

% spec
Fsample = 24/(2*pi);
Wp = 3/Fsample;
Ws = 6/Fsample;
Fp = 3/(2*pi);
Fs = 6/(2*pi);
Pass = 1-(10^(-0.2/20));
Stop = 10^(-44/20);
Wcut = (Wp+Ws)/2;
Fedge = [Fp Fs];
dev = [Pass Stop];

% Kaiser window method
[N,Wn,beta,ftype] = kaiserord(Fedge,[1 0],dev,Fsample);
H1 = Wcut/pi*sinc(Wcut/pi*(-N/2:N/2));
Kaiser = H1.*kaiser(N+1,beta)';

% frequency response plot
fvtool(Kaiser);

% impulse response plot
x = [0:N];
stem(x,Kaiser);
title('Kaiser'); xlabel('Sample'); ylabel('Magnitude');


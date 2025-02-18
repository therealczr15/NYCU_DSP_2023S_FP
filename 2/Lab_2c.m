clc;
clear all;

% spec
Fsample = 24/(2*pi);
Wp = 3/Fsample;
Ws = 6/Fsample;
Fp = 3/(2*pi);
Fs = 6/(2*pi);
Wcut = (Wp+Ws)/2;
Pass = 1-(10^(-0.2/20));
Stop = 10^(-44/20);
Fedge = [Fp Fs];
dev = [Pass Stop];

% Parks-McClellan method
[N,Fo,Ao,w] = firpmord(Fedge,[1 0],dev,Fsample);
Parks = firpm(N+2,Fo,Ao,w);
x=[0:N+2];

% frequency response plot
fvtool(Parks,1);

% impulse response plot
stem(x,Parks);
title('Parks-McClellan'); xlabel('Sample'); ylabel('Magnitude');


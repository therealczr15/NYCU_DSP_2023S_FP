clc;
clear all;

% spec
Fs = 24/(2*pi);
Wp = 3/Fs; 
Ws = 6/Fs;
Pass = 0.2; 
Stop = 44;
Wcut = (Wp+Ws)/2;

% calculate window length(M)
Dw = Ws-Wp;
M_Ham = 8*pi/Dw;
M_Han = 8*pi/Dw;
M_Black = 12*pi/Dw;

% set impulse response
x_Ham = -M_Ham/2 : M_Ham/2;
x_Han = -M_Han/2 : M_Han/2;
x_Black = -M_Black/2 : M_Black/2;

% calculate the ideal filter
Id_Ham = Wcut/pi*sinc(x_Ham*Wcut/pi);
Id_Han = Wcut/pi*sinc(x_Han*Wcut/pi);
Id_Black  = Wcut/pi*sinc(x_Black*Wcut/pi);

% windowing
real_Ham = Id_Ham.*hamming(M_Ham+1)';
real_Han = Id_Han.*hanning(M_Han+1)';
real_Black = Id_Black.*blackman(M_Black+1)';

% frequency response plot
legend(fvtool(real_Ham,1,real_Han,1,real_Black,1) ,'Hamming','Hanning','Blackman');

% impulse response plot
subplot(3,1,1); 
stem(x_Ham,real_Ham);
title('Hamming'); xlabel('Sample'); ylabel('Magnitude');

subplot(3,1,2); 
stem(x_Han, real_Han);
title('Hanning'); xlabel('Sample'); ylabel('Magnitude');

subplot(3,1,3); 
stem(x_Black,real_Black);
title('Blackman'); xlabel('Sample'); ylabel('Magnitude');




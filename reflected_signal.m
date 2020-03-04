function spectr = reflected_signal(something)
% close all;
% clear all;
% clc;
typeAC = 1; % 1 - вертолет, 2 - самолет, 3 - квадрокоптер
if typeAC == 1
Fv = [3.2 18.7];
N = [5 3];
fi0 = [30 30]; %начальное угловое положение 1-ой лопасти
sigma = [4.5 6].*10^(-3); %ЭПР лопасти
R1 = [1.25 0.075];
R2 = [10.35 1];
x0 = [205 217];
y0 = [200 199];
z0 = [50 50];
elseif  typeAC == 2
    N = 3;
    Fv = 25;
    fi0 = 30;
    sigma = 4.5*10^(-3);
    R1 = 0.1;
    R2 = 0.8;
    x0 = 205;
    y0 = 200;
    z0 = 50;
elseif  typeAC == 3
Fv = [85 94 83 96]; %в Гц частота вращения винта
N = [2 2 2 2]; %количество лопастей НВ вертолета
fi0 = [30 30 150 150]; %начальное угловое положение 1-ой лопасти
sigma = [1 1 1 1].*10^(-3); %ЭПР лопасти
R1 = [0.0025 0.0025 0.0025 0.0025];
R2 = [0.115 0.115 0.115 0.115]; % в м удаленность отражателей от центра винта
x0 = [205 204.76 204.76 205];
y0 = [200 200 199.76 199.76];
z0 = [10 10 10 10];% в м начальные координаты центра винта
end
v = 0; % в м/с скорость полёта
Fd = 96000; %частота дискретизации в Гц
%f0 = 666; % в МГц несущая частота ЗС
L = 96000;
T = 1/Fd;
t = (0:L-1)*T;
f = Fd*(0:(L-1))/L;
%c = 3*10^8;
k = 1; %константа в мощности
l = 0.45; % длина волны в м
kv = 2.*pi./l; %волновое число
shag = l/4;
for i = 1:length(Fv)
    Rr = R1(i):shag:R2(i);
for ni = 1:N(i)
    for ri = 1:length(Rr)
        fi1 = 2.*pi.*Fv(i).*t + (ni-1)*2*pi/N(i) + fi0(i); %закон изменения углового положения нной лопасти
        R = Rr(ri);
        if typeAC == 1 && i == 2 
        x1= x0(i) + v.*t + R.*cos(fi1);
        y1 = y0(i);
        z1 = z0(i)- R.*sin(fi1);
        elseif typeAC == 2
        x1= x0 + v.*t + R.*cos(fi1); 
        y1 = y0;
        z1 = z0- R.*sin(fi1);
        else
        x1= x0(i) + v.*t + R.*cos(fi1); 
        y1 = y0(i) - R.*sin(fi1);
        z1 = z0(i); %законы изменения координат во времени  
        end
        r1 = sqrt(x1.^2+y1.^2+z1.^2); %закон изменения дальности
        power1 = (k*sigma(i))./(r1.^4); %закон изменения мощности
        energy1 = sqrt(2.*power1); %закон изменения энергии
        finr1 = 2.*kv.*r1; 
        signal1 = energy1.*exp(1i.*finr1);
        if ni == 1 && ri == 1
            signal = signal1;
        end
        signal = signal + signal1;
    end
end
if i == 1
    Signal_ = signal;
end
    Signal_ = Signal_ + signal;
end
wn = (rand(1,length(t)))./20000;%noise
Signal = Signal_ + wn; %+ wn
% figure
  norm = max(Signal);
  Signal = Signal./norm;
%   plot(t,real(Signal))
 spectr = abs(fftshift(fft(Signal)));
 nor= max(spectr);
 spectr = spectr./nor;
% spectr = 10.*log(spectr);

% disp(spectr)

disp(something)

%  figure
% plot(f,spectr)
% xlim([47000 49000])
end
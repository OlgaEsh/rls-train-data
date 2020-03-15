function spectr = reflected_signal_new(helicopterAC)
% close all;
% clear all;
% clc;
typeAC = 1;% 1 - ��������, 2 - �������, 3 - ������������
% helicopterAC = 1 % 1 - MI-8, 2 - MI-2, 3 - MI-24
if typeAC == 1 && helicopterAC == 1
Fv = [3.2 18.7];
N = [5 3];
fi0 = [30 30]; %��������� ������� ��������� 1-�� �������
sigma = [0.5 100].*10^(-3); %��� �������
R1 = [1.25 0.075];
R2 = [10.35 1];
x0 = [205 217];
y0 = [200 199];
z0 = [50 50];
v = 20; % � �/� �������� �����
elseif typeAC == 1 && helicopterAC == 2
Fv = [4.1 24.25];
N = [3 2];
fi0 = [30 30]; %��������� ������� ��������� 1-�� �������
sigma = [2 50].*10^(-3); %��� �������
R1 = [0.1 0.083];
R2 = [12.25 1.9125];
x0 = [205 217];
y0 = [200 199];
z0 = [50 50];
v = 0; % � �/� �������� �����
elseif typeAC == 1 && helicopterAC == 3
Fv = [4 18.7];
N = [5 3];
fi0 = [30 30]; %��������� ������� ��������� 1-�� �������
sigma = [1 25].*10^(-3); %��� �������
R1 = [0.1 0.083];
R2 = [8.65 1.9125];
x0 = [205 217];
y0 = [200 199];
z0 = [50 50];
v = 0; % � �/� �������� �����
elseif  typeAC == 2
    N = 3;
    Fv = 25;
    fi0 = 30;
    sigma = 5.5*10^(-3);
    R1 = 0.1;
    R2 = 0.8;
    x0 = 205;
    y0 = 200;
    z0 = 50;
    v = 25; % � �/� �������� �����
elseif  typeAC == 3
Fv = [85 94 83 96]; %� �� ������� �������� �����
N = [2 2 2 2]; %���������� �������� �� ���������
fi0 = [30 30 150 150]; %��������� ������� ��������� 1-�� �������
sigma = [20 20 20 20].*10^(-3); %��� �������
R1 = [0.0025 0.0025 0.0025 0.0025];
R2 = [0.115 0.115 0.115 0.115]; % � � ����������� ����������� �� ������ �����
x0 = [205 204.76 204.76 205];
y0 = [200 200 199.76 199.76];
z0 = [10 10 10 10];% � � ��������� ���������� ������ �����
v = 40; % � �/� �������� �����
end
Fd = 96000; %������� ������������� � ��
%f0 = 666; % � ��� ������� ������� ��
L = 96000;
T = 1/Fd;
t = (0:L-1)*T;
f = Fd*(0:(L-1))/L;
%c = 3*10^8;
k = 1; %��������� � ��������
l = 0.45; % ����� ����� � �
kv = 2.*pi./l; %�������� �����
shag = l/4;
for i = 1:length(Fv)
    Rr = R1(i):shag:R2(i);
for ni = 1:N(i)
    for ri = 1:length(Rr)
        fi1 = 2.*pi.*Fv(i).*t + (ni-1)*2*pi/N(i) + fi0(i); %����� ��������� �������� ��������� ���� �������
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
        z1 = z0(i); %������ ��������� ��������� �� �������  
        end
        r1 = sqrt(x1.^2+y1.^2+z1.^2); %����� ��������� ���������
        power1 = (k*sigma(i))./(r1.^4); %����� ��������� ��������
        energy1 = sqrt(2.*power1); %����� ��������� �������
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
set(0,'DefaultAxesFontSize',12,'DefaultAxesFontName','Arial');
set(0,'DefaultTextFontSize',12,'DefaultTextFontName','Arial'); 
% figure
  norm = max(Signal);
  Signaln = Signal./norm;
%   plot(t,real(Signaln))
 spectr = abs(fftshift(fft(Signal)));
 max0 = find(spectr == max(spectr));
 spectr(max0) = 0;
 nor= max(spectr);
 spectr = spectr./(2*nor);
 
%  disp(helicopter_AC)
 
%spectr = 10.*log(spectr);
% set(0,'DefaultAxesFontSize',12,'DefaultAxesFontName','Arial');
% set(0,'DefaultTextFontSize',12,'DefaultTextFontName','Arial'); 
%  figure
% plot(f,spectr)
% xlim([47000 49000])
% ylim([0 1])
% xticks([47000 47500 48000 48500 49000])
% xticklabels({'-1000', '-500', '0', '500', '1000'})
end
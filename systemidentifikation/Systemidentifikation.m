%% Matlab Code zur Systemidentifikation
% Bitte Strg-Enter Section f�r Section durch. An manchen Stellen musst du
% selber Werte eingeben. Lies also bitte die Kommentare.

clear; clc; close all;
data = csvread('Systemidentifikation1.txt',1,0);
Time = data(:,2)/1000;
Speed = data(:,3);
Set = data(:,4);
%% Untersuchen der Sprungantwort
hold off;
plot(Time(:),Speed(:),'r*');
hold on;
plot(Time(:),Set(:));
hold off;


%% Folgende Werte bitte manuell erheben
i_jump_soll = 328; %660; % Der Eintrag, der mit dem Sprung der Soll gr��e �bereinstimmt.
i_jump_ist = 331; %663; % Letzter Punkt bei dem die Regelgr��e noch null ist.
i_stable_start = 340; %685; % Der Bereich in dem Geschwindigkeit stabil ist nach dem einpendeln.
i_stable_end = 350; %695;

% Errechnent einiger tempor�rer Werte
jump = Set(i_jump_soll+1)-Set(i_jump_soll-1);
tjump = Time(i_jump_soll);  % Zeitpunkt des Sprungs
avg = mean(Speed(i_stable_start:i_stable_end)); % Der Bereich in dem Geschwindigkeit stabil ist nach dem einpendeln.
P1 = [Time(i_jump_ist),Speed(i_jump_ist)];    % Letzter Punkt bei dem die Regelgr��e noch null ist.
P2 = [Time(i_jump_ist+2),Speed(i_jump_ist+2)];    % 1-2 Punkte Sp�ter
dt = 0;
for i=1:length(Time)-1
    dt(i)=Time(i+1)-Time(i);
end
dt = mean(dt);

% Anlegen der Tangente
m=(P2(2)-P1(2))/(P2(1)-P1(1));
y0=-P1(1)*m+P1(2);

% Kreuzungspunkt finden
%fit linear polynomial
p1 = [0 Set(i_jump_soll)];
p2 = [m y0];
%calculate intersection
x_intersect = fzero(@(x) polyval(p1-p2,x),3);
y_intersect = polyval(p1,x_intersect);
tcross = x_intersect;

% Plotten
hold off;
plot(Time(:),Speed(:),'r*');
hold on;
plot(Time(:),Set(:));
plot(Time,m*Time+y0,'g--');
line([tjump tjump],[-100 Speed(i_stable_start)+500],'Color','k','LineStyle',':');
line([tcross tcross],[-100 Speed(i_stable_start)+500],'Color','k','LineStyle',':');
line([Time(i_jump_soll)-0.1 Time(i_stable_end)],[avg avg],'Color','k','LineStyle',':');
plot(x_intersect,y_intersect,'mo')
xlim([Time(i_jump_soll)-0.1 Time(i_stable_end)]);
ylim([0-100 Speed(i_stable_start)+500]);

% Aufstellen der �bertragungsfunktion
Ttot = P1(1)-tjump
T = tcross-Time(i_jump_ist) %tjump
ks = avg/jump;
s=tf('s');
S = tf([ks], [T 1], 'inputdelay', Ttot); % S = exp(-Ttot*s)*ks/(T*s+1);
%S = c2d(S,dt);

%% Identifizieren der �bertragungsfunktion
% Bitte T anpassen bis optimal, danach PID-Parameter anpassen bis optimal.
%T = 0.05
kp = 0.01;
ki = 0.4/(2*T*ks);
kd = 0;

% Aufstellen des PID Reglers
R = pid(kp,ki,kd);
% R = c2d(R,dt);
% Geschlossener Regelkreis
G0 = R*S;   % Reihenschaltung von g1,S (z.B. Regler und Strecke) 
G = feedback(G0,1);    % R�ckkopplung(Gegenkopplung) mit 
                        % f0 im Vorw�rtszweig, 1 im R�ckw�rtszweig
                        % ->F�hrungs�bertragungsfuktion 

% Plot
hold off;
Time2 = (Time(i_jump_soll:i_stable_end)-Time(i_jump_soll));
plot(Time2,Speed(i_jump_soll:i_stable_end)/jump,'r*');
hold on;
S = tf([ks], [T 1], 'inputdelay', Ttot); % S = ks/(T*s+1);
% S = c2d(S,dt);
step(S);
xlim([0 Time(i_stable_end)-Time(i_jump_ist)]);
ylim([0 ks+1]);
step(ks*G);
hold off;

%%
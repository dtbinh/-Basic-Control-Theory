%% Parameters
k1 = 1;     %Spring Coefficients1
k2 = 5;     %Spring Coefficients2
m1 = 1;     %Mass1
m2 = 0.5;   %Mass2
r = 10;     %Desired Position

%% System Performance
OS = 20;     %Percent Overshoots
Ts = 4;     %Settling Times

%% Linearlized System
    %dx = Ax+Bu
    %y = Cx+Du
A = [ 0 0 1 0 0 ; 0 0 0 1 0 ; -(k1+k2)/m1 k2/m1 0 0 1/m1 ; k2/m2 -k2/m2 0 0 0 ; 0 0 0 0 0];
B = [0;0;0;0;1];
C = [0 1 0 0 0];
D = 0;

%% Pole Analysis & Second Order Approximation
sigma = -4/Ts;                              
omega = sigma*pi/log(OS/100);
P = [sigma + omega*1i,sigma - omega*1i];
P_aprox = 20*[sigma-0.5,sigma,sigma+0.5];
Poles = [P,P_aprox];

%% Poles Placement
K = place(A,B,Poles);   %Control Gain

%% Full-State Feedbacks Control
    %u = -Kx + Nr
N = -1/(C/(A-B*K)*B);   %Steady-State Error Compensator Gain
assignin('base', 'N', N)
assignin('base', 'A', A)
assignin('base', 'B', B)
assignin('base', 'K', K)
assignin('base', 'r', r)

%% Simulation
sim('Sim.slx');
x = x_out1.data;
t = tout;

%% Animation Parameters
L1 = 1;
L2 = 5;
w1 = 1/2;
w2 = 1/2;
box1 = [-w1 w1 w1 -w1 -w1 ; w1 w1 -w1 -w1 w1];
box2 = [-w2 w2 w2 -w2 -w2 ; w2 w2 -w2 -w2 w2];

%% Animation
N = numel(t);

figure('Name','Animation','Windowstate','maximized')
subplot(2,2,3)
hold on 
axis([0 max(t)+0.5 0 max(x(:,2))+1]);
plot([t(1) t(end)],[r r],'k--','linewidth',1);
title('Actual-Outputs versus Times')
xlabel('Times(seconds)')
ylabel('Output')

for i = 1:N-1
    subplot(2,2,[1,2])
    hold on 
    axis equal
    axis([0 max(x(:,2))+L1+L2+2 -2 2]);
    B1 = plot(box1(1,:)+L1+x(i,1),box1(2,:),'b','linewidth',1);
    B2 = plot(box2(1,:)+L1+L2+x(i,2),box2(2,:),'r','linewidth',1);
    
    L_s1 = L1+x(i,1)-w1;                  %Spring1 Length
    L_s2 = (L2+x(i,2) - x(i,1))-w1-w2;    %Spring2 Length
    N_s1 = 0:0.01:L_s1;        
    N_s2 = 0:0.01:L_s2;             
    Spring1 = plot(N_s1,0.2*sin(2*pi*(5/L_s1)*N_s1),'b','linewidth',1);
    Spring2 = plot(N_s2+L1+x(i,1)+w1,0.2*sin(2*pi*(5/L_s2)*N_s2),'r','linewidth',1);
    title('Animation')
    xlabel('x')
    ylabel('y')
    
    subplot(2,2,3)
    hold on 
    plot([t(i) t(i+1)],[x(i,2),x(i+1,2)],'r','linewidth',1);
    
    subplot(2,2,4)
    hold on 
    axis([0 max(t)+0.5 min(x(:,5))-1 max(x(:,5))+1]);
    plot([t(i) t(i+1)],[x(i,5),x(i+1,5)],'k','linewidth',1);
    title('Control Inputs versus Times')
    xlabel('Times(Seconds)')
    ylabel('Input')
    
    pause((t(i+1)-t(i)))
    if i ~= N-1
        delete(B1);
        delete(B2);
        delete(Spring1);
        delete(Spring2);
    end
end


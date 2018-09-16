function simTest
[t,x] = ode45(@(t,x)dynamics(t,x,0),[0 10],[0;pi/4;0;0]);
subplot(2,1,1)
plot(t,x(:,1))
axis([0 10 -50 0])
subplot(2,1,2)
plot(t,x(:,2))
axis([0 10 pi/4 5])
end

function dx = dynamics(t,x,u)
M = 1;
m = 0.5;
l = 1;
b = 0.05;
beta = 0.5;
g = 9.80665;
q = x(1:2);
qd = x(3:4);

D = [M+m m*l*cos(q(2)) ; m*l*cos(q(2)) m*l^2];
C = [ 0 m*l*sin(q(2))*qd(2) ; 0 0];
B = [b 0 ; 0 beta];
G = [0;-m*g*l*sin(q(2))];
K = [1;0];
qdd = D\[-C*qd-B*qd-G+K*u];
dx = [qd;qdd];
end
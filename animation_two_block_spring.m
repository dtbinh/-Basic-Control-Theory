%% parameters
load('two_block_spring.mat')
e_v = -0.2; %initial position of mass v (+ bottom, - Top)
e_h = -1; %initial position of mass h (+ left, - right)
d_e = 0.5; %spring equilibium
assignin('base', 'e_v', e_v)
assignin('base', 'e_h', e_h)
assignin('base', 'd_e', d_e)

sim('two_blocks_w_spring.slx');
%% Block
w_v = 0.1; %width of mass v
w_h = 0.15; %width of mass h
m_v = [-w_v w_v w_v -w_v -w_v ; w_v w_v -w_v -w_v w_v];
m_h = [-w_h w_h w_h -w_h -w_h ; w_h w_h -w_h -w_h w_h];

%% Input
x = q.data; %q = [x_v; x_m]
t = q.time;
n = numel(t);
x1 = x(:,1);
x2 = x(:,2);

%% plot
hold on
plot([-3 3 3 -3],[w_h+0.01 w_h+0.01 -w_h-0.01 -w_h-0.01],'k','linewidth',1);
plot([w_v w_v -w_v -w_v],[3 -3 -3 3],'k','linewidth',1);
axis equal
axis([-max(abs(x2))-0.15 max(abs(x2))+0.15 -max(abs(x1))-0.1 max(abs(x1))+0.1]);
for i = 1:n-1
    M_v = plot(m_v(1,:),m_v(2,:)+x1(i)-e_v,'k','linewidth',1);
    M_h = plot(m_h(1,:)+x2(i)-e_h,m_h(2,:),'k','linewidth',1);
    
    l = sqrt((x1(i)-e_v)^2 + (x2(i)-e_h)^2);
    ang = atan2(x1(i)-e_v,e_h-x2(i));
    trans = [cos(ang) -sin(ang) x2(i)-e_h;sin(ang) cos(ang) 0; 0 0 1];
    
    N = 0:0.01:l;
    s = trans*[N; 0.05*sin(2*pi*(10/l)*N);ones(1,numel(N))];
    
    Spring = plot(s(1,:),s(2,:),'k','linewidth',1);

    pause(t(i+1)-t(i))
    if i ~= n-1
        delete(M_v)
        delete(M_h)
        delete(Spring)
    end
end

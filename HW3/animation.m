function animation(x_out)
    x = x_out.data;
    t = x_out.time;
    l = 1;
    w = 0.25;
    for i = 2:numel(t)-1
        subplot(2,2,[1 3])
        hold on
        cart = plot([-w+x(i,1) w+x(i,1) w+x(i,1) -w+x(i,1) -w+x(i,1)],[w w -w -w w],'k','linewidth',2);
        pole = plot([x(i,1) x(i,1)+l*sin(x(i,2))],[0 l*cos(x(i,2))],'k','linewidth',2);
        mass = plot(x(i,1)+l*sin(x(i,2)),l*cos(x(i,2)),'ok','linewidth',4);
        plot([x(i,1)+l*sin(x(i,2)) x(i-1,1)+l*sin(x(i-1,2))],[l*cos(x(i,2)) l*cos(x(i-1,2))],'--r','linewidth',1);
        axis equal
        axis([-10 2 -1 1]);
        
        subplot(2,2,2)
        hold on
        plot([t(i-1) t(i)],[x(i-1,1) x(i,1)],'b','linewidth',1);
        axis equal
        axis([0 t(numel(t)) -10 10]);
        
        subplot(2,2,4)
        hold on
        plot([t(i-1) t(i)],[x(i-1,2) x(i,2)],'b','linewidth',1);
        axis equal
        axis([0 t(numel(t)) -5 5]);
        
        pause(t(i)-t(i-1));
        if i ~= numel(t)-1
            delete(cart)
            delete(pole)
            delete(mass)
        end
   end
end
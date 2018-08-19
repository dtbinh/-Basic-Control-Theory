function out = def_int(f,a,b,n)
    dx = (b-a)/n;
    out = f(a)+f(b);
    for i = a+dx:dx:b-dx
        out = out+2*f(i);
    end
    out = dx/2*out;
end
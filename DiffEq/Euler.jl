function euler(
    (t0,tN) = (0,1),  #Initial Time
    u0;
    f,   #Set of functions
    h = 0.01, 
)
    us = [];
    ts = []
    
    for t in range(t0,tN,step = h)
        push!(ts,t0 .+ n * h)
        push!(us,)
    end

    return ts,us
end

function naive_euler(
    N :: Number,
    f :: Function,
    (tL,tR) = (0,1),
    u0 :: Number

)
    h = (tR - tL) / N

    us = Vector(undef,N)
    ts = Vector(undef,N)

    us[1] = u0
    ts[1] = tL
    for n in 1:N+1
        ts[n+1] = ts[n] + h
        us[n+1] = us[n] + h * f(ts[n],us[n])
    end

    return (ts,us);
end
function euler(
    N :: Number,
    f :: Function,
    u0 :: Number,
    (tL,tR) = (0,1),

)
    h = (tR - tL) / N

    us = Vector(undef,N)
    ts = Vector(undef,N)

    us[1] = u0
    ts[1] = tL
    for n in 1:N-1
        ts[n+1] = ts[n] + h
        us[n+1] = us[n] + h * f(ts[n],us[n])
    end

    return (ts,us);
end


function euler(
    (t0,tN) = (0,1),  #Initial Time
    (u0,uN),  #Initial
    f,   #Set of functions
    h = 0.01, 
)
    us = [];
    ts = []
    
    for t in range(t0,tN,step = h)
        push!(ts,t0 .+ n * h)
        push!(us,t)
    end

    return ts,us
end
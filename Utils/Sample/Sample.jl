function create_sample(
    xs      :: Array{<:Number},
    f       :: Function,
    noise   :: Function,
) :: Array{<:Number}

ys = @. f(xs) 

m = size(ys)

mtx = noise(m[1])
for n in m[2:length(m)]
    ns = noise(n)
    print(ns)
    mtx = hcat(mtx,ns)
end 
#TODO
#ns = noise(size(ys))


return ys + mtx
end

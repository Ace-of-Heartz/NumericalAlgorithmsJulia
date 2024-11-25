struct ButcherTable
    A :: AbstractVector 
    B :: AbstractMatrix 
    C :: AbstractVector 
    row :: Number 
    col ::Number

    function ButcherTable(
        a::AbstractVector,
        b::AbstractMatrix,
        c::AbstractVector)
        row = length(a)
        col = length(c)
        new(a,b,c,row,col)
    end 

end

const BT = ButcherTable

function gen_2nd_order_bt(alpha :: Number) :: BT
    if alpha == 0
        error("Zero is not allowed for the value of alpha!\nα ≠ 0\n")
    end
    
    bt = BT(
        [0,alpha],
        [0 0; alpha 0],
        [1-1/(2*alpha), 1/(2*alpha)]
    )

    return bt
end

function heun_bt() :: BT 
    bt = BT(
        [0,1/2],
        [0 0; 1/2 0],
        [0,1] 
    ) 

    return bt
end

function ralston_bt()
    bt = BT(
        [0, 2/3],
        [0 0; 2/3 0],
        [1/4, 3/4]
    )

    return bt
end

function classic_4th_bt()
    bt = BT(
        [0, 1/2, 1/2, 1],
        [0 0 0 0; 1/2 0 0 0; 0 1/2 0 0; 0 0 1 0],
        [1/6, 1/3, 1/3, 1/6]
    )

    return bt
end

print("ButcherTables.jl successfully included")


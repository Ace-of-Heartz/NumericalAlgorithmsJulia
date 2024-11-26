struct BezierCurve
    __ps
    
    function insert_point(
        p, 
        idx :: Integer
        )
        insert!(__ps,idx,p)
    end
    
    function get_points()
        return __ps
    end
end

struct BezierSurface
    curves :: AbstractArray{<:BezierCurve}
end

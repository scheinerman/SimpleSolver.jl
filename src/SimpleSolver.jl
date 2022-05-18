module SimpleSolver
using NLsolve

export simple_solve

""" 
    simple_solve(f, x0)
    simple_solve(f, df, x0)
Solve the equation `f(x)==0` in one real variable. Here, `x0` is an initial guess
and `df` is the derivative of `f`.
"""
function simple_solve(f::Function, x0::Real)
    x = [Float64(x0)]
    y = [1.0]

    function f!(y, x)
        y[1] = f(x[1])
    end

    t = nlsolve(f!, x)
    return (t.zero)[1]
end


function simple_solve(f::Function, df::Function, x0::Real)
    x = [Float64(x0)]
    y = [1.0]
    dy = [1.0]

    function f!(y, x)
        y[1] = f(x[1])
    end

    function df!(dy,x)
        dy[1] = df(x[1])
    end
    
    t = nlsolve(f!, df!, x)
    return (t.zero)[1]
end

include("bisection.jl")

end # module

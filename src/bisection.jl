export bisection_solve
"""
    bisection_solve(f::Function, a::Real, b::Real, tol::Real=1e-8)
Solve the equation `f(x)=0` in the interval `[a,b]`. We require `f(a)*f(b) <= 0`.
"""
function bisection_solve(f::Function, a::Real, b::Real, tol::Real = 1e-8)
    if tol <= 0
        error("Tolerance must be positive")
    end

    fa = f(a)
    if abs(fa) <= tol
        return a
    end

    fb = f(b)
    if abs(fb) <= tol
        return b
    end

    if fa * fb > 0
        error("Initial values $a and $b yield function values of the same sign")
    end

    while true
        c = (a + b) / 2
        fc = f(c)
        if abs(f(c)) <= tol
            return c
        end

        if sign(fc) != sign(f(b))
            a = c
            fa = fc
        else
            b = c
            fb = fc
        end
    end

end

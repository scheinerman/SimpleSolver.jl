const MAX_ITERATIONS = 20

export newton_solve
"""
    newton_solve(f::Function, df::Function, x0::Number)
    newton_solve(f::Function, df::Function, x0::Number, tol::Real)
Solve the equation `f(x) = 0` in one variable using Newton's method. Here `x0`
is an initial guess and `df` is the derivative of `f`.

Here `x0` may be `Complex`.
"""
function newton_solve(f::Function, df::Function, x0::Number, tol::Real = DEFAULT_TOL)
    if tol <= 0
        error("Tolerance must be positive")
    end

    x = x0
    count = 0

    while true
        y = f(x)
        if abs(y) <= tol
            return x
        end
        dy = df(x)
        x = x - y / dy
        count += 1
        if count > MAX_ITERATIONS
            return NaN 
        end
    end
end

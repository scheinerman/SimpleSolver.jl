# This is a test of the methods when the derivative at the root is zero

using SimpleSolver

function rel_err(val::Real, actual::Real)
    return (val - actual) / actual
end

f(x) = (x - 2)^2;
df(x) = 2 * (x - 2);


@info "Double root test: f(x) = (x-2)^2"

x = simple_solve(f, 1)
e = rel_err(x, 2)
@info "Simple solve, no derivative:\t error = $e"

x = simple_solve(f, df, 1)
e = rel_err(x, 2)
@info "Simple solve, with derivative:\t error = $e"

x = newton_solve(f, df, 1)
e = rel_err(x, 2)
@info "Newton solve, with derivative:\t error = $e"



f(x) = (x - 2)^3;
df(x) = 3 * (x - 2)^2;

println()

@info "Triple root test: f(x) = (x-2)^3"

x = simple_solve(f, 1)
e = rel_err(x, 2)
@info "Simple solve, no derivative:\t error = $e"

x = simple_solve(f, df, 1)
e = rel_err(x, 2)
@info "Simple solve, with derivative:\t error = $e"

x = bisection_solve(f, 1, 5)
e = rel_err(x, 2)
@info "Bisection solve:\t\t error = $e"

x = newton_solve(f, df, 1)
e = rel_err(x, 2)
@info "Newton solve, with derivative:\t error = $e"


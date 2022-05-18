using BenchmarkTools, SimpleSolver

# This test looks for a fixed point of cosine which is known to lie
# between 0 and 1.

f(x) = cos(x) - x
df(x) = -sin(x) - 1
x0 = 1
a = 0
b = 1

@info "Speed test of the SimpleSolver methods"

print("simple_solve(f,$x0)\t")
@btime simple_solve(f, x0)

print("simple_solve(f,df,$x0)\t")
@btime simple_solve(f, df, x0)

print("bisection_solve(f,$a,$b)\t")
@btime bisection_solve(f, a, b)

print("newton_solve(f,df,$x0)\t")
@btime newton_solve(f, df, x0)

@info "Test complete"

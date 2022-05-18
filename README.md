# SimpleSolver

This module provides an easy way to solve equations in a single real variable. 
It relies on [NLsolve](https://github.com/JuliaNLSolvers/NLsolve.jl).

## Solving equations

Use the function `simple_solve` to solve equations of the form `f(x) = 0`. The simplest
form is `simple_solve(f,x0)` where `x0` is an initial guess for the solution. 
```julia
julia> simple_solve(cos,1)
1.570796326795489

julia> cos(ans)
-5.923537736000261e-13
```

Efficiency is gained by providing the derivative `df` of `f` by calling 
`simple_solve(f,df,x0)`.

```julia
julia> f(x) = x^2-2;

julia> df(x) = 2x;

julia> simple_solve(f,df,1)
1.4142135623746899

julia> ans^2
2.0000000000045106
```

### Problems

An initial value `x0` where the derivative of the function is zero can cause trouble.
```julia
julia> simple_solve(cos,0)
NaN
```

Likewise, trouble ensues if the equation has no solution.
```julia
julia> f(x) = x^2 + 1;

julia> simple_solve(f,1)
NaN
```




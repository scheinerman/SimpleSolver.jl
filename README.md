# SimpleSolver

This module provides an easy way to solve equations in a single real variable. 
It relies on [NLsolve](https://github.com/JuliaNLSolvers/NLsolve.jl).

## Solving equations using `simple_solve`

The function `simple_solve` is used to solve equations of the form `f(x) = 0`. The simplest
form is `simple_solve(f,x0)` where `x0` is an initial guess for the solution. 
```
julia> simple_solve(cos,1)
1.570796326795489

julia> cos(ans)
-5.923537736000261e-13
```

Efficiency is gained by providing the derivative `df` of `f` by calling 
`simple_solve(f,df,x0)`.

```
julia> f(x) = x^2-2;

julia> df(x) = 2x;

julia> simple_solve(f,df,1)
1.4142135623746899

julia> ans^2
2.0000000000045106
```

### Problems

An initial value `x0` where the derivative of the function is zero can cause trouble.
```
julia> simple_solve(cos,0)
NaN
```

Likewise, trouble ensues if the equation has no solution.
```
julia> f(x) = x^2 + 1;

julia> simple_solve(f,1)
NaN
```


## Solving equations with `bisection_solve`

The function `bisection_solve` solves the equation `f(x) = 0` on an interval `[a,b]` where
`f(a) * f(b) <= 0`. 
```
julia> bisection_solve(cos,0,2)
1.5707969665527344
```

To increase accuracy, an optional tolerance argument may be provided:
```
julia> bisection_solve(cos,0,2,1e-10)
1.5707963267341256

julia> pi/2
1.570796326794896
```

`bisection_solve` uses the bisection method and does not rely on `NLsolve`. 
It tends to be faster than `simple_solve`, but requires two starting values
whose function values have opposite sign.

### Problems
An error is generated if `f(a)` and `f(b)` have the same sign:
```
julia> bisection_solve(cos,0,1)
ERROR: Initial values 0 and 1 yield function values of the same sign
```

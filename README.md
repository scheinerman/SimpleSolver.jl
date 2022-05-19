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


## Solving equations using `bisection_solve`

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


## Solving equations using `newton_solve`

The `newton_solve` function solves equations of the form `f(x) = 0` using Newton's method.
The syntax is `newton_solve(f, df, x0)` where `df` is the derivative of `f` and `x0` is
an initial guess. It may also be invoked as  `newton_solve(f, df, x0, tol)`.

This method allows complex arguments.
```
julia> f(x) = x^2 + 2;

julia> df(x) = 2x;

julia> z = newton_solve(f, df, 2+im)
7.204091011552923e-13 + 1.4142135623765002im   # essentially 0 + sqrt(2)*im
```


# Speed Comparison

The file `test/speed_test.jl`  compares the speeds of the various methods. 
In all cases, we seek a solution to the equation `cos(x) = x` which
is known to lie between `0` and `1`.
```
[ Info: Speed test of the SimpleSolver methods
simple_solve(f,1)         2.921 μs (54 allocations: 3.16 KiB)
simple_solve(f,df,1)      2.380 μs (49 allocations: 2.73 KiB)
bisection_solve(f,0,1)    484.451 ns (1 allocation: 16 bytes)
newton_solve(f,df,1)      156.034 ns (1 allocation: 16 bytes)
[ Info: Test complete
```

The pros and cons are as follows:
+ `simple_solve` does not require a derivate and needs only a single starting value,
but is the slowest.
+ `bisection_solve` does not require a derivative, but needs two 
starting values that yield opposite signs.
+ `newton_solve` requires a derivative, but is the fastest.



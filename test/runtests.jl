using SimpleSolver, Test

f(x) = x^2 - 2
df(x) = 2x

@testset "simple_solve" begin
    x = simple_solve(f, 1)
    @test abs(x * x - 2) <= 1e-6

    x = simple_solve(f, df, 1)
    @test abs(x * x - 2) <= 1e-6
end


@testset "bisection_solve" begin
    x = bisection_solve(f, 1, 2)
    @test abs(x * x - 2) <= 1e-6
end


@testset "newton_solve" begin
    x = newton_solve(f, df, 1)
    @test abs(x * x - 2) <= 1e-6

    g(x) = x^2 + 3
    dg(x) = 2x

    x = newton_solve(g, df, 1 + im)
    @test abs(x^2 + 3) <= 1e-6
end


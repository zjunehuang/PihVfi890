using PihVfi890
using Test

function euler_test()
    @testset "Euler" begin
        m = init_test_model();
        t = 2;
        k = 5.0;
        kPrimeTomorrow(kPrime) = 0.5 .* kPrime;

        kPrime = solve_one_point(m, t, k, kPrimeTomorrow);
        dev = euler_dev_one_point(m, t, k, kPrime, kPrimeTomorrow);
        @test kPrime > kprime_min(m, t);
        @test kPrime < kprime_max(m, t);
        @test abs(dev) < 1e-4
        dev2 = euler_dev_one_point2(m, t, k, kPrime, kPrimeTomorrow);
        @test abs(dev2) < 1e-4
    end
end

function solve_test()
    @testset "Solve" begin
        m = init_test_model();
        kPrime_tV = solve(m);
    end
end

@testset "VFI" begin
    euler_test();
    solve_test();
end
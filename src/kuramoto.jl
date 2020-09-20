using LightGraphs, DifferentialEquations, Plots, LinearAlgebra


lil(a) = vcat(a, circshift(reverse(a),1))

function circulant_kura(a::Vector) # a is half vec
	n = 2length(a)
    g = SimpleGraph(reshape(vcat(map(x->circshift(lil(a), x), 0:(n-1))...), (n, n)))
    dgs = degree(g)
    @assert all(x->x==dgs[1], dgs)
    println("μ: $(dgs[1]/(n-1))")
    # println("fake connectivity: ≈$((round(ne / binomial(nv, 2), digits=2)))")
    g
end

# shitty wrapper
function kura_prob(u0, tspan, p)::ODEProblem
    ODEProblem(kuramoto!, u0, tspan, p)
end

function kuramoto!(du, u, p, t)
    n = length(u)
    A, ω = p # A is adjacency_matrix, and ω is 
    u .+= ω * t
    for i in 1:n
        du[i] = sum(A[i, j] * sin(u[j] - u[i]) for j in 1:n)
    end
end


function anim_kura(u0, g)
    θn = θo = u0
    # p = scatter(θo)
    # p = plot(20)
    p = scatter(u0)
    anim = @animate for _ in 1:100
       θn = kuramoto(g, θo)
       println("$(θn - θo)")
       push!(p, 20, θn)
       θo = θn
    end
end 

function demo(g)

    u0 = rand(nv(g))
    tspan = (0., 10.)
    p = (adjacency_matrix(g), 10.)
    ODEProblem(kuramoto!, u0, tspan, p)

end

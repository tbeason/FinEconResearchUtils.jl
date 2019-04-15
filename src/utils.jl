using LinearAlgebra
import SparseArrays: spdiagm

# remove linear time trend
function detrend(y::Vector{Float64})
	n = length(y)
	@assert n >= 4
	
	x = [ones(n) collect(1:n)]
	c=x\y
	return y-x*c
end

# Hodrick-Prescott Filter
# derived from: http://www.econforge.org/posts/2014/juil./28/cef2014-julia/
# output is (trend component, cyclical component)
function hp_filter(y::Vector{Float64}, lambda::Real;detrendfirst::Bool = false) 
	n = length(y)
	@assert n >= 4

	if detrendfirst
		y = detrend(y)
	end
	diag2 = lambda*ones(n-2)
	diag1 = [ -2lambda; -4lambda*ones(n-3); -2lambda ]
	diag0 = [ 1+lambda; 1+5lambda; (1+6lambda)*ones(n-4); 1+5lambda; 1+lambda ]

	D = spdiagm(-2=>diag2, -1=>diag1, 0=>diag0, 1=>diag1, 2=>diag2)
	t=D\y
	t, y-t
end




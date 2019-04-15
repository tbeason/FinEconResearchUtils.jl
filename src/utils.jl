using LinearAlgebra
using RollingFunctions
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

lastnonzero(X) = (y=filter(!iszero,X); !isempty(y) ? last(y) : 0.0)
dropcols(df::AbstractDataFrame, cols) = df[setdiff(names(df), cols)]
yrqtrfun(dt) = string(year(dt),"Q",quarterofyear(dt))



function rollingfillfirst(fun::Function, data::AbstractArray{T1,1}, windowspan::Int64,filler::T2) where {T1,T2<:Union{Missing,Number}}
	TL = size(data,1)
	FL = windowspan - 1
	outtmp = allowmissing(zeros(TL))
	outtmp[1:FL] .= filler
	outtmp[(1+FL):end]=rolling(fun,data,windowspan)
	return outtmp
end

function rollingfillfirst(fun::Function, data1::AbstractArray{T1,1},data2::AbstractArray{T1,1},windowspan::Int64,filler::T2) where {T1,T2<:Union{Missing,Number}}
	TL = size(data1,1)
	TL2 = size(data2,1)
	@assert TL == TL2
	FL = windowspan - 1
	outtmp = allowmissing(zeros(TL))
	outtmp[1:FL] .= filler
	outtmp[(1+FL):end]=rolling(fun,data1,data2,windowspan)
	return outtmp
end








function tomissing!(d::AbstractDataFrame,x::Union{Integer,Symbol})
	allowmissing!(d,x)
	d[findall(isnan,d[x]),x] = missing
end

function alltomissing!(d::AbstractDataFrame)
	for nm in names(d)
		if eltype(d[nm]) <: Float64
			if any(isnan,d[nm])
				tomissing!(d,nm)
			end
		end
	end
end



function maxdrawdown(R)
	T = length(R)
	P = 100 .* cumprod(1 .+ R)
	DD = zeros(size(R))
	peak = -999.99
	for i = 1:T
		if P[i] > peak
			peak = P[i]
		end
		DD[i] = (P[i]-peak)/peak
	end
	maxDD = minimum(DD)
end



module FinEconResearchUtils

using Reexport
    @reexport using Dates
    @reexport using Statistics
    @reexport using DataFrames
    @reexport using DataFramesMeta
    @reexport using Missings
    @reexport using ShiftedArrays
    @reexport using CSVFiles
    @reexport using ExcelFiles
    @reexport using StatFiles
    @reexport using SASLib
    @reexport using BeaData
    @reexport using FredData
    @reexport using StatsBase
    @reexport using GLM
    @reexport using Distributions
    @reexport using RollingFunctions

include("utils.jl")

export rollingfillfirst, 
    detrend, hp_filter,
    tomissing!, alltomissing!,
    maxdrawdown,
    lastnonzero, dropcols, yrqtrfun


end # module

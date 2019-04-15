
# FinEconResearchUtils.jl

[![Build Status](https://travis-ci.com/tbeason/FinEconResearchUtils.jl.svg?branch=master)](https://travis-ci.com/tbeason/FinEconResearchUtils.jl)


A collection of useful packages and utilities for doing financial economics research in Julia. This package is intended for endusers and not intended to become part of a package development chain. 

The package does two things:
 1. It brings together several other useful (to me at least!) packages for doing data work and simple data analysis in Julia. Thus, you can `using FinEconResearchUtils.jl` and get access to many packages at once, such as: 
    - **Base**: Dates+Statistics
    - **Tabular Data**: DataFrames+DataFramesMeta+Missings+ShiftedArrays
    - **Importing Data**: CSVFiles+ExcelFiles+StatFiles+SASLib
    - **Fetching Data**: BeaData+FredData
    - **Statistics**: StatsBase+GLM+Distributions+RollingFunctions
 2. It contains a small collection of functions that I use repeatedly, but haven't found in any other package.
    - Functions helping with simple data manipulation
    - Trend-cycle filters (Hodrick-Prescott, Hamilton)
    - Rolling-window statistics
    
 
For help regarding functionality provided by any of these packages, please refer to the package's own documentation.
 
I have chosen not to include plotting functionality, as plotting preferences tend to be quite heterogeneous (I use GR.jl and PGFPlotsX.jl).
 
 
## Setup

To add this package to your Julia installation simply type `]` at the Julia REPL to enter the package manager and then type
```julia
add https://github.com/tbeason/FinEconResearchUtils.jl
```
 
After installation, return to the REPL and type `using FinEconResearchUtils.jl`.
 
Two packages require additional setup to use their functionality, those are BeaData.jl and FredData.jl. You must register on the BEA or FRED websites to receive an API key before using these packages. If you do not wish to use this functionality, it will not interfere with this package if you do not register.


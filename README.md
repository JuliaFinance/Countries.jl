# Countries.jl

<!-- [![Build Status](https://travis-ci.org/JuliaFinance/ISOCurrencies.jl.svg?branch=master)](https://travis-ci.org/JuliaFinance/ISOCurrencies.jl)
[![Build status](https://ci.appveyor.com/api/projects/status/1593mlsleriaex4j?svg=true)](https://ci.appveyor.com/project/EricForgy/isocurrencies-jl) -->

## Purpose

This package provides standard country names and various codes.

## Data Source

Data for this package was obtained from https://datahub.io/core/country-codes.

## Usage

This package provides a `Country` type with the following fields:

```julia
struct Country
    name::String
    code::Int
    currency::Currencies.Currency
    capital::String
    continent::String
    developed::Bool
    region::String
    subregion::String
end
```

You can access a country using its 2-character ISO code:

```julia
julia> using Countries
julia> Countries.US
Countries.Country("United States of America", 840, US Dollar, "Washington", "NA", true, "Americas", "Northern America")
```
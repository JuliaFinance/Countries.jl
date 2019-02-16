# Countries.jl

<!-- [![Build Status](https://travis-ci.org/JuliaFinance/ISOCurrencies.jl.svg?branch=master)](https://travis-ci.org/JuliaFinance/ISOCurrencies.jl)
[![Build status](https://ci.appveyor.com/api/projects/status/1593mlsleriaex4j?svg=true)](https://ci.appveyor.com/project/EricForgy/isocurrencies-jl) -->

## Purpose

This package provides standard country names and various codes.

## Data Source

Data for this package was obtained from https://datahub.io/core/country-codes.

## Usage

```julia
julia> using Countries
julia> import Countries: name, code, capital, continent, isdeveloping, region, subregion, currencies, US, PH, HK, SG
julia> cs = [US,PH,HK,SG];
julia> for c in cs
       println("Country: $(c)")
       println("Name: $(name(c))")
       println("Code: $(code(c))")
       println("Capital: $(capital(c))")
       println("Continent: $(continent(c))")
       println("Developing: $(isdeveloping(c))")
       println("Region: $(region(c))")
       println("Subregion: $(subregion(c))")
       println("Currencies: $(currencies(c))\n")
       end

Country: US
Name: United States of America
Code: 840
Capital: Washington
Continent: NA
Developing: false
Region: Americas
Subregion: Northern America
Currencies: Currencies.Currency[USD]

Country: PH
Name: Philippines
Code: 608
Capital: Manila
Continent: AS
Developing: true
Region: Asia
Subregion: South-eastern Asia
Currencies: Currencies.Currency[PHP]

Country: HK
Name: China, Hong Kong Special Administrative Region
Code: 344
Capital: Hong Kong
Continent: AS
Developing: true
Region: Asia
Subregion: Eastern Asia
Currencies: Currencies.Currency[HKD]

Country: SG
Name: Singapore
Code: 702
Capital: Singapore
Continent: AS
Developing: true
Region: Asia
Subregion: South-eastern Asia
Currencies: Currencies.Currency[SGD]
```
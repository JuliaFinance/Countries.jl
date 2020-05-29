# Countries.jl

This is a core package for the JuliaFinance ecosytem. 

It provides the `Country` singleton type, based on the ISO 3166 standard
together with nine methods:

- `symbol`: The 2-character ISO 3166 alpha symbol of the country.
- `country`: The singleton type instance for a particular country symbol.
- `name`: The full name of the country.
- `code`: The ISO 3166 code for the country.
- `capital`: The capital of the country.
- `continent`: The continent of the country.
- `isdeveloping`: Whether the country is developed or is developing (boolean).
- `region`: The region of the country.
- `subregion`: The subregion of the country.

## Usage

```julia
julia> using Countries
julia> import Countries: country, symbol, name, code, capital, continent, isdeveloping, region, subregion, currencies
julia> cs = country.([:US,:PH,:HK,:SG]);
julia> for c in cs
       println("Country: $(symbol(c))")
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
Currencies: [:USD]

Country: PH
Name: Philippines
Code: 608
Capital: Manila
Continent: AS
Developing: true
Region: Asia
Subregion: South-eastern Asia
Currencies: [:PHP]

Country: HK
Name: China, Hong Kong Special Administrative Region
Code: 344
Capital: Hong Kong
Continent: AS
Developing: true
Region: Asia
Subregion: Eastern Asia
Currencies: [:HKD]

Country: SG
Name: Singapore
Code: 702
Capital: Singapore
Continent: AS
Developing: true
Region: Asia
Subregion: South-eastern Asia
Currencies: [:SGD]
```

## Data Source

Data for this package was obtained from https://datahub.io/core/country-codes.

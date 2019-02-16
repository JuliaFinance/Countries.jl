using Countries
import Countries: name, code, capital, continent, isdeveloping, region, subregion, currencies, US, PH, HK, SG

using Test

countries = [US,PH,HK,SG]
names = ["United States of America","Philippines","China, Hong Kong Special Administrative Region","Singapore"]
codes = [840,608,344,702]
capitals = ["Washington","Manila","Hong Kong","Singapore"]
continents = ["NA","AS","AS","AS"]
isdevelopings = [false,true,true,true]
regions = ["Americas","Asia","Asia","Asia"]
subregions = ["Northern America","South-eastern Asia","Eastern Asia","South-eastern Asia"]

for (c,nm,cd,cp,ct,dv,rg,sr) in zip(countries,names,codes,capitals,continents,isdevelopings,regions,subregions)
    @test name(c) == nm
    @test code(c) == cd
    @test capital(c) == cp
    @test continent(c) == ct
    @test isdeveloping(c) == dv
    @test region(c) == rg
    @test subregion(c) == sr
end

# Sheet 19: Attributes on Their Own: Bob's Beer Belly

Model: [`SysMLv2_Attributes.sysml`](SysMLv2_Attributes.sysml) (package `BobsBeerBelly`). It is the code printed on the cheat sheet, followed by a view a tool can render: `bellyView`.

Attributes are more than fields on a part: an `attribute def` is a value type you can reuse, and an attribute usage can stand on its own and be subset everywhere it applies, the way the library's `ISQ::mass` is typed by `MassValue`.

The cheat sheet itself is in the book *A Model Universe: Cheat Sheets for SysML v2 and the stories behind them*.

## Try it

1. **Drop a multiplicity.** Remove `[1]` from `beerMass :> ISQ::mass [1]`. What multiplicity does `beerMass` have now?
2. **Change the unit.** Give Bob a body mass in pounds and check that `totalMass` still makes sense.

## Challenges

1. **A temperature.** Add `attribute fridgeTemp :> ISQ::thermodynamicTemperature [1];` to a fridge and give it a value in °C.
2. **A structured value.** Write `attribute def Receipt` with a `ref part buyer : Person` and a price, and use it on a beer run.
3. **Your own standalone usage.** Declare `attribute calories : Real [*] nonunique;` and subset it in `Beer` and in a pizza.

## Share your model

Add a folder named with your GitHub ID under `communityModels/`, put your model in it and open a pull request, all in the browser. [CONTRIBUTING.md](../../CONTRIBUTING.md) walks through it step by step with an example, and gives the house rules (funny, valid SysML v2, nothing that would make your mom blush) and how submissions may be used.

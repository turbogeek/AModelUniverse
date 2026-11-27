# Sheet 17: Inside an Interface: Bob Pulls the Plug

Model: [`SysMLv2_Interfaces.sysml`](SysMLv2_Interfaces.sysml) (package `BobsBlackout`). It is the code printed on the cheat sheet, followed by a view a tool can render: `blackoutView`.

The cheat sheet itself is in the book *A Model Universe: Cheat Sheets for SysML v2 and the stories behind them*.

## Challenges

1. **Downgrade the plug.** Change `interface tonight` to a plain `connect fridge.plug to algernon.socket;`. The model still parses. Find the sentence in [S] 7.14.2 that says the `BeerLow` now goes nowhere.
2. **Meet Charlie.** Add a third generator, a hamster named Charlie, and connect it with `interface fridge.plug to charlie.socket;`. How many places could each alert go now?
3. **Flip a direction.** Add `out attribute temp : Real;` to `DataPort`. What does it become on the `~` side, and why?

## Share your model

Add a folder named with your GitHub ID under `communityModels/`, put your model in it and open a pull request, all in the browser. [CONTRIBUTING.md](../../CONTRIBUTING.md) walks through it step by step with an example, and gives the house rules (funny, valid SysML v2, nothing that would make your mom blush) and how submissions may be used.

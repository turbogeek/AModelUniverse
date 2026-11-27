# Sheet 17: Inside an Interface: Bob Pulls the Plug

Model: [`SysMLv2_Interfaces.sysml`](SysMLv2_Interfaces.sysml) (package `BobsBlackout`). It is the code printed on the cheat sheet, followed by a view a tool can render: `blackoutView`.

The cheat sheet itself is in the book *A Model Universe: Cheat Sheets for SysML v2 and the stories behind them*.

## Challenges

1. **Downgrade the plug.** Change `interface tonight` to a plain `connect fridge.plug to algernon.socket;`. The model still parses. Find the sentence in [S] 7.14.2 that says the `BeerLow` now goes nowhere.
2. **Meet Charlie.** Add a third generator, a hamster named Charlie, and connect it with `interface fridge.plug to charlie.socket;`. How many places could each alert go now?
3. **Flip a direction.** Add `out attribute temp : Real;` to `DataPort`. What does it become on the `~` side, and why?

## Share your model

Fork this repository, add your model as `submissions/17-interfaces/<your GitHub name>/<name>.sysml`, check it with a SysML v2 validator, and open a pull request. See [CONTRIBUTING.md](../../CONTRIBUTING.md).

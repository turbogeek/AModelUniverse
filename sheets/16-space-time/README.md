# Sheet 16: Space and Time: Bob Lands on the Moon

Model: [`SysMLv2_SpaceTime.sysml`](SysMLv2_SpaceTime.sysml) (package `BobOnTheMoon`). It is the code printed on the cheat sheet, followed by a view a tool can render: `landingView`.

The cheat sheet itself is in the book *A Model Universe: Cheat Sheets for SysML v2 and the stories behind them*.

## Challenges

1. **A fifth leg.** Change `legCount` to 5 and work out `maxSlope` by hand from `MaxSlope`. Does `staysUp` still hold on a 10 degree slope?
2. **Move the beer.** Lower the `beer` load from 38 m to 25 m. How much does `zCG` drop, and how much steeper a slope can Bob now land on?
3. **Add a snapshot.** Add a `snapshot part refuelled` with 150 t of fuel and say which of the three snapshots is the most likely to tip.

## Share your model

Fork this repository, add your model as `submissions/16-space-time/<your GitHub name>/<name>.sysml`, check it with a SysML v2 validator, and open a pull request. See [CONTRIBUTING.md](../../CONTRIBUTING.md).

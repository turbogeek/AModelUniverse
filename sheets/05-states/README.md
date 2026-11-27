# Sheet 5: States: Bob Goes Super

Model: [`SysMLv2_States.sysml`](SysMLv2_States.sysml) (package `BobStates`). It is the code printed on the cheat sheet, followed by views a tool can render: `modesView`, `bobStructure`.

The cheat sheet itself is in the book *A Model Universe: Cheat Sheets for SysML v2 and the stories behind them*.

## Challenges

1. **Bob needs a nap.** Add a `sleeping` state inside `normal`, entered from `drinking` when `bac` passes 0.08, and leave it on a new `WakeUp` item. Does a `HeroCall` still reach Bob while he sleeps?
2. **Super hearing.** Add a fourth region, `ears`, to `super` with states `quiet` and `listening`. Check that it runs at the same time as `flight`, `eyes` and `fists`, and not one after another.
3. **Two ways to end the day.** Swap `then done` and `then crash` on the `Retire` and `BlueScreen` transitions. Explain what changes for whoever is waiting on `modes` to finish.

## Share your model

Add a folder named with your GitHub ID under `communityModels/`, put your model in it and open a pull request, all in the browser. [CONTRIBUTING.md](../../CONTRIBUTING.md) walks through it step by step with an example, and gives the house rules (funny, valid SysML v2, nothing that would make your mom blush) and how submissions may be used.

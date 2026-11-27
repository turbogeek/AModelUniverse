# Sheet 9: Expressions: Bob Counts Beers

Model: [`SysMLv2_Expressions.sysml`](SysMLv2_Expressions.sysml) (package `BobsFridge`). It is the code printed on the cheat sheet, followed by a view a tool can render: `fridgeView`.

The cheat sheet itself is in the book *A Model Universe: Cheat Sheets for SysML v2 and the stories behind them*.

## Challenges

1. **Count the warm ones.** Write `countWarm`, the number of warm beers, using `size` and `.?{ }`.
2. **Average strength.** Write a `calc def Average` that reuses `Tab` and `size`. What should it return for an empty fridge, and how does `??` help?
3. **Beat the precedence table.** Predict `-1 ** 2 + 2 ^ 3 ^ 2` before you look anything up, then check it against the ladder on the sheet. (Answer: 1 + 512 = 513.)

## Share your model

Add a folder named with your GitHub ID under `communityModels/`, put your model in it and open a pull request, all in the browser. [CONTRIBUTING.md](../../CONTRIBUTING.md) walks through it step by step with an example, and gives the house rules (funny, valid SysML v2, nothing that would make your mom blush) and how submissions may be used.

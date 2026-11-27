# Sheet 6: Actions: Bob Plays Pickleball

Model: [`SysMLv2_Actions.sysml`](SysMLv2_Actions.sysml) (package `BobsPickleball`). It is the code printed on the cheat sheet, followed by views a tool can render: `swimlanes`, `gameStructure`, `gameFlow`.

The cheat sheet itself is in the book *A Model Universe: Cheat Sheets for SysML v2 and the stories behind them*.

## Challenges

1. **Give the Professor a lane.** Add a `professor` part to `court` that performs a new `callScore` action after every `point`. Where does it go in the succession, and which lane draws it?
2. **Win by two.** The game ends at `target`, but real pickleball needs a two-point lead. Change the decision after `point` so the game only ends when the leader is ahead by two.
3. **Swap the server.** Make SuperBob serve to Bob. Change the `send ... to` and `accept ... via` lines, then explain why a reusable library version would pass the receiver in as a parameter instead of naming `court.superBob`.

## Share your model

Fork this repository, add your model as `submissions/06-actions/<your GitHub name>/<name>.sysml`, check it with a SysML v2 validator, and open a pull request. See [CONTRIBUTING.md](../../CONTRIBUTING.md).

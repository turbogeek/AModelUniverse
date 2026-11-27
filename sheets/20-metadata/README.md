# Sheet 20: Metadata & #Keywords: Sticky Notes

Model: [`SysMLv2_Metadata.sysml`](SysMLv2_Metadata.sysml) (package `BobsStickyNotes`). It is the code printed on the cheat sheet, followed by two views: `untouchables`, filtered by metadata, and `stickyView`, a view a tool can render.

Metadata is SysML v2's sticky note: tags, structured notes, notes restricted to certain kinds of element, and your own `#keywords`.

The cheat sheet itself is in the book *A Model Universe: Cheat Sheets for SysML v2 and the stories behind them*.

## Try it

1. **Break a rule.** Put `@FridgeNote { temp = 4.0; }` on `item def Beer`. Which tool catches it?
2. **Forget a value.** Write `@Approval { approved = true; }` without an approver.

## Challenges

1. **A status board.** Mark three parts with `@StatusInfo { status = StatusKind::tbd; }` and write a view that shows only those.
2. **Your own keyword.** Make `#hazard` for occurrences, and declare `#hazard occurrence fridgeEmpty;`.
3. **A risk.** Add `@Risk` to the reactor with a technical risk level.

## Share your model

Add a folder named with your GitHub ID under `communityModels/`, put your model in it and open a pull request, all in the browser. [CONTRIBUTING.md](../../CONTRIBUTING.md) walks through it step by step with an example, and gives the house rules (funny, valid SysML v2, nothing that would make your mom blush) and how submissions may be used.

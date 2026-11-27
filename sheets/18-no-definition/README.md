# Sheet 18: When There Is No Def: Where's the Def?

Model: [`SysMLv2_NoDefinition.sysml`](SysMLv2_NoDefinition.sysml) (package `WhereIsTheDef`). It is the code printed on the cheat sheet, followed by a view a tool can render: `noDefView`.

Most SysML v2 elements come in pairs, a definition and its usages. This sheet collects the ones that don't: usage-only kinds you can never write a `def` for.

The cheat sheet itself is in the book *A Model Universe: Cheat Sheets for SysML v2 and the stories behind them*.

## Try it

1. **Break it on purpose.** Change `bind` to `binding def Link;`, or `message order` to `message def Order;`. Read the errors.
2. **Find the hidden def.** Open the standard library in your tool and look up `SendAction`, `StateTransitionAction` and `Flows::Message`.

## Challenges

1. **A def for the flow.** Write a `flow def` with a payload, and type a flow usage with it.
2. **A message chain.** Model three messages in order with `then`, the way the use case examples in SysML 7.25.2 do.
3. **A variation.** Give Bob's snacks a `variation` with three `variant`s, and pick one in a specialization.

## Share your model

Add a folder named with your GitHub ID under `communityModels/`, put your model in it and open a pull request, all in the browser. [CONTRIBUTING.md](../../CONTRIBUTING.md) walks through it step by step with an example, and gives the house rules (funny, valid SysML v2, nothing that would make your mom blush) and how submissions may be used.

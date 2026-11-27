# A Model Universe

Code, descriptions and cartoons from **A Model Universe**, created by Daniel Brookshier: one-page
SysML v2 cheat sheets, the newsletters that tell how each one happened, and the lab where Bob,
SuperBob, the Professor and Algernon the mouse keep getting the notation wrong so you don't have to.

Follow A Model Universe on Daniel's LinkedIn account: https://www.linkedin.com/in/danielbrookshier/

This repository holds the example model behind every cheat sheet, ready to load in your SysML v2 tool,
and the reader challenges from the newsletters. The sheets and the stories are collected in the book
**A Model Universe: Cheat Sheets for SysML v2 and the stories behind them**.

## What's here

| Folder | Sheet | Package |
| --- | --- | --- |
| [`sheets/01-02-basics-and-beyond`](sheets/01-02-basics-and-beyond) | 1 and 2: the basics, beyond the basics | `CheatSheetExamples` |
| [`sheets/03-requirements`](sheets/03-requirements) | 3: requirements | `RequirementsExamples` |
| [`sheets/04-validation-patterns`](sheets/04-validation-patterns) | 4: validation patterns | `ValidationPatterns` |
| [`sheets/05-states`](sheets/05-states) | 5: states (Bob goes super) | `BobStates` |
| [`sheets/06-actions`](sheets/06-actions) | 6: actions and swimlanes (Bob plays pickleball) | `BobsPickleball` |
| [`sheets/07-colon-family`](sheets/07-colon-family) | 7: the colon family | `TheColonFamily` |
| [`sheets/08-quantities-units`](sheets/08-quantities-units) | 8: quantities and units | `SuperBobsUnits` |
| [`sheets/09-expressions`](sheets/09-expressions) | 9: expressions (Bob counts beers) | `BobsFridge` |
| [`sheets/10-why-wont-it-parse`](sheets/10-why-wont-it-parse) | 10: why won't it parse? | `BobsGarage` |
| [`sheets/11-which-line`](sheets/11-which-line) | 11: which line do I draw? | `BobsBeerPipeline` |
| [`sheets/12-rosetta-stone`](sheets/12-rosetta-stone) | 12: v1 to v2 Rosetta Stone | `ProfessorsFridge` |
| [`sheets/13-own-it-or-use-it`](sheets/13-own-it-or-use-it) | 13: own it or use it | `BobsBorrowedMower` |
| [`sheets/14-allocation`](sheets/14-allocation) | 14: allocate without double duty | `BobsBarbecue` |
| [`sheets/15-variants`](sheets/15-variants) | 15: variants and variations | `BobsPizzaFamily` |
| [`sheets/16-space-time`](sheets/16-space-time) | 16: space and time (Bob lands on the Moon) | `BobOnTheMoon` |
| [`sheets/17-interfaces`](sheets/17-interfaces) | 17: inside an interface (Bob pulls the plug) | `BobsBlackout` |
| [`sheets/18-no-definition`](sheets/18-no-definition) | 18: when there is no def (where's the def?) | `WhereIsTheDef` |
| [`sheets/19-attributes`](sheets/19-attributes) | 19: attributes on their own (Bob's beer belly) | `BobsBeerBelly` |
| [`sheets/20-metadata`](sheets/20-metadata) | 20: metadata and #keywords (sticky notes) | `BobsStickyNotes` |

Every model is the code printed on its cheat sheet, followed by a view your tool can render. Each one
passes a SysML v2 syntax validator against the standard library, and every keyword traces to a numbered
clause of the SysML v2.1 or KerML specification.

## Try it yourself

1. Pick a sheet folder and open its `.sysml` file in your SysML v2 tool, or paste it into a SysML v2 Jupyter notebook.
2. Render the view at the end of the package and compare it with the cheat sheet.
3. Do the challenges in the folder's README.
4. Share your answer: add a folder named with your GitHub ID under `communityModels/` and open a pull request. [CONTRIBUTING.md](CONTRIBUTING.md) shows how, with an example.

## License

Reader submissions are also covered by the terms in [CONTRIBUTING.md](CONTRIBUTING.md#how-your-work-may-be-used): the book and merchandise that fund this project may use them, with credit.

This site is under the following Creative Commons License: CC BY-NC-SA 4.0
https://creativecommons.org/licenses/by-nc-sa/4.0/

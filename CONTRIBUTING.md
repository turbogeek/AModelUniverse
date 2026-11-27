# Share your model

Every newsletter and every sheet README ends with challenges. Answer one, or model something of your
own with the same notation, and add it to this repository so other readers can see your work.

Every contributor gets one folder under `communityModels/`, named with their GitHub ID. All of your
models go in that folder:

```
communityModels/
  example-contributor/          <- one folder per contributor, named with the GitHub ID
    countStrong.sysml
  your-github-id/               <- yours goes here
    countWarm.sysml
    bobsSmartToaster.sysml
```

A real example is in [`communityModels/example-contributor/`](communityModels/example-contributor/countStrong.sysml).
The header at the top of each file says which sheet and challenge it answers.

## House rules

Every model merged here has to pass three tests:

1. **It's funny.** This is *A Model Universe*: Bob, SuperBob, the Professor, Algernon, beer, toast and
   questionable engineering decisions. Teach one idea, and make the reader smile while you do it.
2. **It's correct SysML v2.** It parses against SysML v2.1 and the standard library. Imports carry their
   visibility (`private import ISQ::*;`, never a bare `import`). Check it with a SysML v2 validator or your
   tool before you open the pull request.
3. **It's clean.** Nothing that would make your mom, or Daniel's mom, blush when she reads your code. No
   profanity, no innuendo, no insults, nothing about real people. Bob can be silly; he can't be naughty.

Also:

- **Your own work.** Submit only models you wrote, or that you have the right to share.
- **Stay in your folder.** Pull requests that change other contributors' folders or the sheet models are
  closed; open an issue instead if you found a problem in a sheet.

Pull requests that miss a rule get a friendly comment on what to change. A model that doesn't parse, with
a good question about why, is still welcome as a question; it gets merged once it parses.

## Add your folder and model (in the browser, no git needed)

1. **Sign in to GitHub** and open [`communityModels/`](communityModels).
2. Click **Add file** then **Create new file**.
3. In the file name box, type your GitHub ID, a slash, and the file name:
   `your-github-id/countWarm.sysml`. Typing the `/` creates your folder.
4. **Paste your model.** Start it with this header so readers know what it is and who wrote it:

   ```
   /*
    * Sheet 9, Expressions: challenge 1, countWarm
    * Idea: one or two sentences on what you modeled and anything you learned.
    * Author: your-github-id (GitHub)
    * Submitted under CONTRIBUTING.md: may be used, with credit, in A Model Universe books,
    * newsletters and merchandise; otherwise shared under CC BY-NC-SA 4.0.
    */
   package YourPackageName {
     private import ScalarValues::*;
     ...
   }
   ```

   One package per file. Several files in your folder are fine.
5. Click **Commit changes...**, then **Propose changes**. GitHub keeps a copy of your change under your
   account for you; you don't need to set anything up.
6. On the next page click **Create pull request**. Title it `your-github-id: 09 countWarm`, fill in the
   short checklist, and click **Create pull request** again.

To add more files later, repeat the steps with the same folder name. To add files from your computer,
open `communityModels/your-github-id/` and use **Add file** then **Upload files**.

## What happens next

- Your pull request is reviewed against the house rules.
- When it is merged, your folder appears under `communityModels/` for everyone to read.
- The best answers, and the most instructive wrong ones, are featured in future newsletters.

## How your work may be used

*A Model Universe* is funded by the book and the merchandise made from it. By opening a pull request with a
submission, you agree that:

- You keep the copyright to your work.
- You grant Daniel Brookshier a non-exclusive, worldwide, royalty-free, perpetual license to use, copy,
  adapt, publish and include your submission, in whole or in part, in *A Model Universe* books,
  newsletters, cheat sheets, merchandise and promotion, including commercial products.
- When your work is used, Daniel will try to credit you by the name or GitHub user name in your header.
- Everyone else may use your submission under this repository's license,
  [CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/).

If you don't agree to these terms, please don't submit.

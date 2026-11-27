# Share your model

Every newsletter and every sheet README ends with challenges. Answer one, or model something of your
own with the same notation, and add it to this repository so other readers can see your work.
Each contributor gets their own folder under `submissions/`, next to the sheet it belongs to:

```
submissions/
  09-expressions/
    example-contributor/        <- one folder per contributor, named with your GitHub user name
      countStrong.sysml
    your-github-name/           <- yours goes here
      countWarm.sysml
```

A real example is in [`submissions/09-expressions/example-contributor/`](submissions/09-expressions/example-contributor/countStrong.sysml).

## Add your folder and model (in the browser, no git needed)

1. **Sign in to GitHub** and open the sheet's folder under [`submissions/`](submissions), for example
   `submissions/09-expressions`.
2. Click **Add file** then **Create new file**.
3. In the file name box, type your GitHub user name, a slash, and the file name:
   `your-github-name/countWarm.sysml`. Typing the `/` creates your folder.
4. **Paste your model.** Start it with this header so readers know what it is and who wrote it:

   ```
   /*
    * Sheet 9, Expressions: challenge 1, countWarm
    * Idea: one or two sentences on what you modeled and anything you learned.
    * Author: your-github-name (GitHub)
    * Submitted under CONTRIBUTING.md: may be used, with credit, in A Model Universe books,
    * newsletters and merchandise; otherwise shared under CC BY-NC-SA 4.0.
    */
   package YourPackageName {
     ...
   }
   ```

   One package per file. Several files in your folder are fine.
5. Click **Commit changes...**, then **Propose changes**. GitHub keeps a copy of your change under your
   account for you; you don't need to set anything up.
6. On the next page click **Create pull request**. Title it `09-expressions: countWarm`, fill in the short
   checklist, and click **Create pull request** again.

To add more files to your folder later, repeat the steps with the same folder name. To add files from your
computer, use **Add file** then **Upload files** inside `submissions/<sheet>/<your-github-name>/`.

## What happens next

- Your pull request is reviewed. If something does not parse, you'll get a comment on what to change;
  a model that doesn't parse and a good question about why is still welcome.
- When it is merged, your folder appears under `submissions/` for everyone to read.
- The best answers, and the most instructive wrong ones, are featured in future newsletters.

## Ground rules

- **Your own work.** Submit only models you wrote, or that you have the right to share.
- **Check it first.** Run it through a SysML v2 validator or load it in your tool, and say in the pull
  request if anything is still broken.
- **Stay in your folder.** Pull requests that change other contributors' folders or the sheet models are
  closed; open an issue instead if you found a problem in a sheet.
- **Be friendly and on topic.** Bob makes the mistakes here, not the readers.

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

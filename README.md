# Git-branch-notifier package

## A problem:-
 - You have your git repo opened in an atom.io and have multiple tabs opened.
 - You switch to a different branch. Introduce a new file. Commit that file into this branch. You don't close this tab (the newly introduced file tab).
 - You switch back again to your old branch. You see that the file on your tree view is gone but the tabs remain open.
 - You stay oblivious of the tab change and start editing the newly introduced file from other branch and save!!
 - The file is now saved into the old branch when you really wanted to save it in the other branch.
 [Problem](http://i.imgur.com/DoU5gy6.gif)

 ## Description:-
 This package tries to at the least alert you when you're trying to modify the file from other branch which remained on your panes. And that's it's only purpose.

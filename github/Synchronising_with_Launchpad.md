Basic Instructions for pushing changes back to LaunchPad
========================================================

(Note: these instructions are a work in progress)

1. Checkout the maintenance branch from Launchpad
```
    mkdir bzr
    cd bzr
    bzr init-repo --no-trees repo
    bzr lp-login $USER_LAUNCHPAD         # <-- optional, maybe
    bzr branch lp:~andymc73/maria/oqgraph-maintenance
```
2. Create a git clone of the bazaar repository
(Note: this equires git >= 1.8 in Wheezy, obtain from wheezy-backports )
```
    git clone bzr::path/to/bzr/oqgraph-maintenance
```
Note the above takes rather a long time and produces a >= 5GB working copy...
3. Take a clone of the github OQGraph repository
```
    git clone https://github.com/andymc73/oqgraph
```
4. Fetch the OQGraph repository into the mariadb working copy
One off commands:
```
    cd path/to/bzr-git/oqgraph-maintenance
    git remote add standalone path/to/github/clone
    git fetch standalone master:github
```
5. Determine the range of commits since the last merge of changes.
For convenience, add a tag, for example, if there are four new commits since the last merge to the bzr-git clone:
```
    git tag oqgraph-standalone-baseline github^^^^
```
6. Apply patches and add as needed.
```
    cd storage/oqgraph
    git checkout master
    git checkout -b github-patches-applied
    git diff --stat  oqgraph-standalone-baseline..github
    git diff oqgraph-standalone-baseline..github | git apply --directory=storage/oqgraph -
    git add -p # as required
    git commit -m "msg" # as required 
```
It would probably be useful to ignore `README.md`, `github/` and `.gitignore` at this point.
7. Merge back to the bzr-git master - after testing nothing broke!
```
  git checkout master
  git merge github-patches-applied
```
8. Push back to bzr
```
  git push origin master
  cd path/to/bzr/oqgraph-maintenance
  bzr push
```



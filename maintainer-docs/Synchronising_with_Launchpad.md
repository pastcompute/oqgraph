Basic Instructions for pushing changes back to LaunchPad
========================================================

For maintainers: how to push changes back to Launchpad for proposing for merging to lp:maria.

(Note: these instructions are a work in progress)

1. Checkout the maintenance branch from Launchpad (one-off commands)

        mkdir bzr
        cd bzr
        bzr init-repo --no-trees repo
        bzr lp-login $USER_LAUNCHPAD
        bzr branch lp:~andymc73/maria/oqgraph-maintenance
2. Create a git clone of the bazaar repository (one-off commands)
(Note: this equires git >= 1.8 in Wheezy, obtain from wheezy-backports )

        git clone bzr::path/to/bzr/oqgraph-maintenance
Note the above takes rather a long time and produces a >= 5GB working copy...
3. Take a clone of the github OQGraph repository

        git clone https://github.com/andymc73/oqgraph
4. Fetch the OQGraph repository into the mariadb working copy.

One off commands:

        cd path/to/bzr-git/oqgraph-maintenance
        git remote add standalone path/to/github/clone
        git fetch standalone master:standalone
5. Determine the range of commits since the last merge of changes.

For convenience, add a tag, for example, if there are four new commits since the last merge to the bzr-git clone:

        git fetch standalone master:standalone
        git tag oqgraph-standalone-baseline standalone^^^^
6. Apply patches and add as needed.

        cd storage/oqgraph
        git checkout master
        git checkout -b github-patches-applied
        git diff --stat  oqgraph-standalone-baseline..standalone
        git diff oqgraph-standalone-baseline..standalone | git apply --directory=storage/oqgraph -
        
        # rebuild & regression test here
        
        git add -p # as required
        git commit -m "msg" # as required 
It would probably be useful to ignore `README.md`, `github/` and `.gitignore` at this point.
7. Merge back to the bzr-git master - after testing nothing broke!

        git checkout master
        git merge github-patches-applied
8. Push back to bzr

        git pull # <-- make sure upstream changes merge properly
        
        # rebuild & regression test here
        
        git push origin master
        cd path/to/bzr/oqgraph-maintenance
        bzr push

Basic Instructions for pulling new changes from LaunchPad
========================================================

This is needed if for some reason changes were made in LaunchPad and merged to the bzr branch, or in the intermediate full git clone of MariaDB.


1. Perform a merge from MariaDB (for example)

        cd maria-bzr-working-copy
        bzr pull
        
        # rebuild & regression test here

2. Update the MariaDB git clone

        cd maria-git-working-copy
        git checkout master
        git branch updates-baseline
        git pull
        
        # rebuild & regression test here

3. Merge changes into the standalone git clone

        cd standalone-working-copy
        git checkout master
        git pull
        git checkout launchpad-tracking
        git pull  # <-- should be a NOOP
                
        ( cd path/to/maria-git-working-copy/storage/oqgraph ; git diff --stat updates-baseline..master -- storage/oqgraph )
        
        ( cd path/to/maria-git-working-copy/storage/oqgraph ; \
          git diff updates-baseline..master -- storage/oqgraph ) | \
          git apply --directory=storage/oqgraph -

        # rebuild & regression test here
        
        git add -p # as required
        git commit -m "msg" # as required 
        git push github launchpad-tracking
        git checkout master
        git merge launchpad-tracking
        git push github master


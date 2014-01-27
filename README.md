OQGraph storage engine v3
=========================

Copyright (C) 2007-2014 Arjen G Lentz & Antony T Curtis for Open Query, & Andrew McDonnell

The Open Query GRAPH engine (OQGRAPH) is a computation engine allowing
hierarchies and more complex graph structures to be handled in a
relational fashion. In a nutshell, tree structures and
friend-of-a-friend style searches can now be done using standard SQL
syntax, and results joined onto other tables.

Based on a concept by Arjen Lentz

v3 implementation by Antony Curtis, Arjen Lentz, Andrew McDonnell

For more information, documentation, support, enhancement engineering,
see http://openquery.com/graph or contact graph@openquery.com

Prerequisites
=============

OQGraph requires at least version 1.40.0 of the Boost library. To
obtain a copy of the Boost library, see http://www.boost.org/

MariaDB and Releases
====================

This tree is just the source code for a MariaDB storage engine. It is not overly useful by itself.
To use, obtain a recent copy of MariaDB 10 (>= 10.0.7) and replace the contents of the directory
`storage/oqgraph/` with this soure code, then rebuild MariaDB.

One way to build MariaDB from source is described at https://mariadb.com/kb/en/compiling-mariadb-from-source/

Note that as of January 2014, the official MariaDB >= 10.0.7 source contains OQGraph v3 at that 
location (`storage/oqgraph/`) corresponding to the GitHub git tag `oqgraph-mariadb-10.0.7-git-tracking-base`

Officially MariaDB is hosted at https://launchpad.net/maria using bzr.

When important bugs are fixed or features completed, the commits to this code will be pushed back to the oqgraph
maintenance branch https://code.launchpad.net/~andymc73/maria/oqgraph-maintenance directory `storage/oqgraph`
for subsequent merging into MariaDB.

Install Example:
================

1. Follow the instructions from the MariaDB wiki
2. Before running cmake, do the following:
```
cd storage
rm -rf oqgraph
git clone https://github.com/andymc73/oqgraph
```
3. Continue with cmake, etc.

Rationale
=========

* Although a migration to github is in the works (https://mariadb.atlassian.net/browse/MDEV-5240), 
  MariaDB is hosted on LaunchPad, which uses bzr
* The full MariaDB history exceeds 80000 commits and in git form the .git directory exceeds 5GB. The full history
  for OQGraph v3 is only ~1 MB...
* Maintaining a standalone tree of the storage engine will allow us to consider backports to other versions of MariaDB


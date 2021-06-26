Project Maintenance
===================

Importing Upstream Changes
--------------------------

1. Fetch and insepct the upstream changes:
   ```console
   $ cd solo2
   $ git fetch origin main
   $ git log --stat HEAD..origin/main 
   ```
2. List the upstream commits that modify `runners/lpc55`:
   ```console
   $ cd solo2
   $ git log --oneline HEAD..origin/main -- runners/lpc55
   ```
3. Make sure that you have configured the `solo2` origin and that it is up to
   date:
   ```console
   $ git remote add solo2 https://github.com/solokeys/solo2
   $ git fetch solo2 main
   ```
3. For each commit `$commit` listed in step 2 (in chronological order):
   1. Optionally, if you want to reduce the amount of changes to apply, update
      the `solo2` submodule to the commit’s parent:
      ```console
      $ cd solo2 && git checkout $commit^
      ```
      Ensure that the project still compiles, update the `Cargo.lock` file and
      commit the update:
      ```console
      $ make check
      $ git add solo2 runners/lpc55/Cargo.lock
      $ git commit -S -m "Update solo2 to $commit^"
      ```
   2. Cherry-pick the commit:
      ```console
      $ git cherry-pick $commit
      ```
      You might have to fix merge conflicts or to manually clean-up some paths
      if the commit also touches files outside of runners/lpc55.
   3. Update the `solo2` submodule:
      ```console
      $ cd solo2 && git checkout $commit
      ```
   4. Ensure that the project still compiles and amend the cherry-picked commit:
      ```console
      $ make check
      $ git add solo2 runners/lpc55/Cargo.lock
      $ git commit --amend -S --no-edit
      ```
4. Update the `solo2` submodule:
   ```console
   $ cd solo2 && git checkout origin/main
   ```
   If this caused changes, ensure that the project still compiles, update the
   `Cargo.lock` file and commit the update:
   ```console
   $ make check
   $ git add solo2 runners/lpc55/Cargo.lock
   $ git commit -S -m "Update solo2 to main"
   ```

Updating Dependencies
---------------------

As we use a `Cargo.lock` file to pin the dependency versions, we have to update
these dependencies occasionally:

```console
$ cd runners/lpc55
$ cargo update
$ cd -
$ make check
$ git add runners/lpc55/Cargo.lock
$ git commit -S -m "Update dependencies"
```

Fixing Compilation Issues and Merge Conflicts
---------------------------------------------

There are two major changes that might lead to compilation issues or merge
conflicts when importing upstream changes:
- The component crates are placed in `solo2/components`, not in `components`.
  If a commit modifies `runners/lpc55/Cargo.toml` or
  `runners/lpc55/board/Cargo.toml`, you might have to take this into account.
- We use a `Cargo.lock` file to pin the dependency versions.  If there is a
  compilation issue related to the crate `$crate`, you might have to run `cargo
  update -p $crate` in `runners/lpc55` to make sure that we pull in the latest
  version.  It might take multiple iterations to update all dependencies.

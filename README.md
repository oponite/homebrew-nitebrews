# nitebrews

Homebrew tap for my builds.

| Formula | What it does | Install |
|---------|--------------|---------|
| `lana` | Language with explicit uncertainty; latest public stable release | `brew install oponite/nitebrews/lana` |
| `lana@X.Y.Z` | An exact public Lana release | `brew install oponite/nitebrews/lana@4.0.0` |
| `pls` | Precise-Lean-Streamlined reasoning tool | `brew install oponite/nitebrews/pls` |

## Install Lana

```sh
brew install oponite/nitebrews/lana
lana version
```

The fully qualified install command adds the tap and trusts the selected formula.
Homebrew builds Lana from source and installs its build dependencies. Current
releases need Rust and Python; older releases use CMake and their declared
version-specific dependencies. The installed Lana command does not need Python.

## Upgrade

The Lana release workflow updates this tap after publishing and verifying each
stable GitHub release. Local builds, unpublished tags, drafts, and prereleases
are not installation targets.

```sh
brew update
brew upgrade oponite/nitebrews/lana
```

Updating the tap does not automatically upgrade installed packages.

## Exact versions

Backfilled public releases: **2.0.0, 2.0.1, 2.1.0, 3.0.0, 3.0.1, 4.0.0,
4.1.0**. Each future public stable release also receives
an exact-version formula. List available formulas with:

```sh
brew search '/^lana(@.*)?$/'
```

```sh
brew install oponite/nitebrews/lana@4.0.0
"$(brew --prefix oponite/nitebrews/lana@4.0.0)/bin/lana" version
```

Versioned formulas are keg-only: they remain at the requested version and do not
replace `lana` on your PATH. Multiple versions can coexist. Older versions
retain their original language behavior and bugs; availability is not a promise
of ongoing fixes for those releases.

Sources come from the public GitHub releases and are checked with SHA-256.
All Lana 1.x releases are excluded. Historical formula packaging fixes preserve the released
language source.

## Previous tap name

This repository was renamed from `oponite/homebrew-oponite`. GitHub redirects
its old repository URL to this repository. Existing `oponite/oponite` tap
checkouts can continue fetching updates; new installations should use
`oponite/nitebrews`. Do not recreate the old GitHub repository name, because
that would remove the redirect.

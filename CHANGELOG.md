# Changelog

All notable changes to this project are documented here. The format follows
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and versions follow
[Semantic Versioning](https://semver.org/).

## [0.2.0] - 2026-10-15

### Added

- `teach` skill from Matt Pocock's
  [mattpocock/skills](https://github.com/mattpocock/skills), pinned at
  `49dd158`: type `/teach` to learn a topic over several sessions, with
  lessons, reference sheets and learning records kept in the folder you run
  it in.

## [0.1.1] - 2026-10-15

### Changed

- `CLAUDE.md` release steps: a published tag is never moved or deleted; a fix
  after a release goes in the next patch version.

## [0.1.0] - 2026-10-15

### Added

- `grilling` skill from Matt Pocock's
  [mattpocock/skills](https://github.com/mattpocock/skills), pinned at
  `49dd158`: interviews you about a plan in rounds of numbered questions,
  each with a recommended answer, until every decision is settled.
- `writing-for-agents` skill from the same repo and commit: guidance Claude
  loads when writing skills or `CLAUDE.md`.
- `GLOSSARY.md` with the repo's vocabulary: buckets, user-invoked and
  model-invoked skills, borrowed and original skills, and the grilling terms.
- `CREDITS.md` at the root and in each borrowed skill's folder, naming the
  author, source commit and any local changes.
- `scripts/link-skills.sh`, which symlinks every skill into `~/.claude/skills`
  so a `git pull` keeps them current.
- `CLAUDE.md` rules for adding skills: borrowed skills are copied one at a
  time and stay pinned to their source commit, new skills get a grilling
  session first, and there are no per-skill docs pages.
- `CLAUDE.md` changelog and release steps: every user-visible change gets a
  `CHANGELOG.md` entry in the same commit, versions bump by semver, and each
  version gets an annotated `vX.Y.Z` tag and a GitHub release with that
  version's changelog section as its notes.

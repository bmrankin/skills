Read [GLOSSARY.md](./GLOSSARY.md) for this repo's vocabulary and use its terms.

Skills are organized into bucket folders under `skills/`:

- `productivity/`: daily non-code workflow tools
- `engineering/`: daily code work
- `misc/`: kept around but rarely used, not promoted
- `in-progress/`: being drafted, not promoted
- `deprecated/`: no longer used

Every promoted skill (`productivity/`, `engineering/`) must be listed in the top-level `README.md` and in its bucket's `README.md`, with the skill name linked to its `SKILL.md`. Both group entries into **User-invoked** and **Model-invoked**.

## Invocation

This repo targets Claude only: no `agents/openai.yaml` or other harness-specific metadata.

Every skill is either user-invoked or model-invoked:

- **User-invoked**: `disable-model-invocation: true` in frontmatter. The `description` is a one-line human-facing summary with no trigger list.
- **Model-invoked**: omit it. The `description` keeps rich trigger phrasing ("Use when the user wants...") so auto-invocation fires.

When one skill depends on another, write an explicit instruction to call the Skill tool with the named skill (`Call the Skill tool with "grilling"`), not a relative link into the other skill's folder. Only model-invoked skills can be reached this way; for a user-invoked prerequisite, tell the user to run it.

## Borrowed skills

A borrowed skill keeps its upstream text. When adding one:

1. Copy only that skill's folder from upstream, unchanged, minus `agents/` (never clone or fork the whole upstream repo).
2. Add a `CREDITS.md` in the skill folder naming the author, upstream path, and commit hash, with a **Local changes** section.
3. Add a row to the root `CREDITS.md`.
4. Mark it with the author's name in both `README.md` entries.

Any later edit to a borrowed skill gets a line under **Local changes** in its `CREDITS.md`.

Borrowed skills stay pinned to the commit in their `CREDITS.md`. Re-sync one with upstream only when asked, then update the commit hash and reconcile **Local changes**.

## Docs

No per-skill docs pages. `SKILL.md` plus the `README.md` entries are the documentation.

## Changelog

Record every user-visible change in `CHANGELOG.md` ([Keep a Changelog](https://keepachangelog.com/en/1.1.0/) format, newest first) in the same commit as the change. Bump the version by semver: a new skill is a minor bump, a fix or wording change to an existing skill is a patch, and removing or renaming a skill is a major bump (minor while below 1.0). Re-syncing a borrowed skill goes under **Changed** and names the new upstream commit.

## Writing new skills

Before writing or substantially changing a skill, run a grilling session on it (call the Skill tool with "grilling"). Add any new domain terms that come out of it to `GLOSSARY.md`.

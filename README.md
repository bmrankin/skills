# Skills

My agent skills for Claude.

This repo is modelled on [Matt Pocock's skills](https://github.com/mattpocock/skills). Some skills here are his, copied with attribution (see [CREDITS.md](./CREDITS.md)); the rest are my own.

## Install locally

```bash
scripts/link-skills.sh
```

This symlinks every skill (except `misc/` and `deprecated/`) into `~/.claude/skills`, so a `git pull` keeps them current. Re-run it after adding, removing, or renaming a skill.

## Reference

Skills split on one axis: who can invoke them. **User-invoked** skills fire only when you type them. **Model-invoked** skills can also be reached for by the agent when the task fits. See [GLOSSARY.md](./GLOSSARY.md) for the vocabulary used throughout.

### Productivity

General workflow tools, not code-specific.

**Model-invoked**

- **[grilling](./skills/productivity/grilling/SKILL.md)**: Interview the user relentlessly about a plan, decision, or idea until every branch of the design tree is resolved. The reusable interview primitive other skills build on. _By [Matt Pocock](https://github.com/mattpocock/skills)._

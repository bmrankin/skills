# Skills

My agent skills for Claude.

This repo is modelled on [Matt Pocock's skills](https://github.com/mattpocock/skills). Some skills here are his, copied with attribution (see [CREDITS.md](./CREDITS.md)); the rest are my own.

## Install locally

```bash
scripts/link-skills.sh
```

On Windows, run it from PowerShell 7 instead:

```powershell
./scripts/link-skills.ps1
```

This symlinks every skill (except `misc/` and `deprecated/`) into `~/.claude/skills`, so a `git pull` keeps them current. Re-run it after adding, removing, or renaming a skill.

## Reference

Skills split on one axis: who can invoke them. **User-invoked** skills fire only when you type them. **Model-invoked** skills can also be reached for by the agent when the task fits. See [GLOSSARY.md](./GLOSSARY.md) for the vocabulary used throughout.

### Productivity

General workflow tools, not code-specific.

**User-invoked**

- **[grill-me](./skills/productivity/grill-me/SKILL.md)**: Type `/grill-me` to start a grilling session on a plan or design. A shortcut to the `grilling` primitive. _By [Matt Pocock](https://github.com/mattpocock/skills)._
- **[teach](./skills/productivity/teach/SKILL.md)**: Teach the user a new skill or concept over multiple sessions, using the current directory as a stateful teaching workspace. Run it in a dedicated folder per topic, not in this repo. _By [Matt Pocock](https://github.com/mattpocock/skills)._

**Model-invoked**

- **[grilling](./skills/productivity/grilling/SKILL.md)**: Interview the user relentlessly about a plan, decision, or idea until every branch of the design tree is resolved. The reusable interview primitive other skills build on. _By [Matt Pocock](https://github.com/mattpocock/skills)._
- **[writing-for-agents](./skills/productivity/writing-for-agents/SKILL.md)**: Writing documents for agents: skills, CLAUDE.md, and any doc an agent reaches by a pointer. _By [Matt Pocock](https://github.com/mattpocock/skills)._

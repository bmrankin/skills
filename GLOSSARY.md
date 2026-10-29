# Skills

A collection of agent skills for Claude. Some are borrowed from other collections with attribution, the rest are written here.

## Language

### Skills and where they live

**Skill**:
A folder containing a `SKILL.md` (plus any supporting files) that an agent loads to gain a behaviour or a slash command.
_Avoid_: command, prompt, plugin (a plugin is a bundle of skills)

**Bucket**:
A top-level folder under `skills/` that groups skills by purpose: `productivity/`, `engineering/`, `misc/`, `in-progress/`, `deprecated/`.
_Avoid_: category, section

**Promoted**:
A skill in the `productivity/` or `engineering/` bucket. Promoted skills are listed in the top-level `README.md` and get installed by default.

### Who can fire a skill

**User-invoked**:
A skill only the human can fire, by typing its name. Frontmatter sets `disable-model-invocation: true`.
_Avoid_: manual skill, command-only

**Model-invoked**:
A skill the agent may reach for on its own when a task fits, or the human may type. Its `description` carries trigger phrasing.
_Avoid_: auto skill

**Primitive**:
A model-invoked skill that holds one reusable discipline, which other skills call through the Skill tool rather than re-implementing it. `grilling` is the first.

**Entry point**:
A user-invoked skill whose whole body calls one or more primitives through the Skill tool, giving the human a name to type. `grill-me` is the first.
_Avoid_: alias, wrapper, pointer

### Where a skill came from

**Borrowed skill**:
A single skill hand-picked and copied from another author's collection (never the whole collection), kept as close to verbatim as practical, with a `CREDITS.md` beside it naming the source and commit.
_Avoid_: vendored, forked, imported

**Original skill**:
A skill written in this repo.

**Upstream**:
The collection a borrowed skill was copied from (for most, [mattpocock/skills](https://github.com/mattpocock/skills)).

### Grilling

**Grilling session**:
A structured interview, run by the `grilling` primitive, that stress-tests a plan until every decision is settled and the user confirms shared understanding.
_Avoid_: Q&A, interview loop

**Design tree**:
The model of the thing being grilled: decisions, each with the decisions that depend on it hanging off it.

**Frontier**:
Every decision in the design tree whose prerequisites are already settled, which is everything that can be asked right now.

**Round**:
One frontier, asked in full as numbered questions with recommended answers, then answered in full by the user.

### Daily brief

**MCE calendar email**:
The daily email a Power Automate flow sends from Bryan's MCE Outlook account, with today + 3 days of Outlook events as JSON in its body. `daily-brief` reads it through Gmail.
_Avoid_: Outlook export, calendar digest

## Relationships

- A **Bucket** holds many **Skills**; only `productivity/` and `engineering/` are **Promoted**
- Every **Skill** is either **User-invoked** or **Model-invoked**
- A **Primitive** is always **Model-invoked**
- An **Entry point** is always **User-invoked**, and calls one or more **Primitives**
- Every **Skill** is either a **Borrowed skill** (with a `CREDITS.md`) or an **Original skill**
- A **Grilling session** walks one **Design tree**, a **Round** at a time, until the **Frontier** is empty

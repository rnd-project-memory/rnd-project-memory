# 2026-10-26 · Dogfooding implementation packages on the install-label fix

- **Status:** open
- **Configuration:** Solo
- **Participants:** author — claude-opus-5-5
- **Signed off:** no
- **Tags:** `#adoption` `#template` `#distribution`

---

## Objective

Run the unreleased implementation-package flow on a real change before `v3.7.0` ships:
`install-path` finding 7, where `install.sh` records the last tag as the version of a skeleton that
has changed since that tag.

## Reasoning

**Where the package lives.** The root runs `v3.6.0`, which has no `implementations/`. The package is
opened in the root's `ai-sandbox/implementations/` anyway, since a package is content and its
directory is the project's. It uses the templates and playbooks in `skeleton/` directly, and
`bash skeleton/check.sh` for status. The root's mechanism files are not raised ahead of the release.
That stays the release's job.

**Package opened** as `IMP-2026-10-26-install-unreleased-label`, with an `opened` row in the root's
new `implementations/LOG.md`. `DESIGN.md` was drafted from `install-path` finding 7. It records
honestly rather than refusing, `T+<sha>` and `T+<sha>-dirty`, and adds a gate that installs from a
throwaway clone in three states.

**Dogfood finding 1: a draft plan read as executable.** Before `PLAN.md` was copied in, `check.sh`
reported *no PLAN.md* while the package was at the design stage. The playbook says to copy both
templates at opening, and this session had skipped it. Once copied, the template's placeholder
steps would have been listed as `ready`. A plan that is not released must offer nothing to
execute. Fixed in `skeleton/check.sh`: an unreleased plan gets structure findings only, plus the
line *not released — no step is executable*.

**The log's conventions, at the author's request.** The author asked for the implementation log to
carry the session log's search instructions, and whether tags apply. Each convention of the session
and experiment logs was weighed:

| Convention | Applies | How |
|---|---|---|
| append only | yes | already |
| search, don't read whole | yes | `rg` by topic, by tag, and by ID for one package's history |
| a hit points at the record, not the log | yes | the ID is the directory |
| the row names what was resolved | yes, per event | `revised` (steps and the report behind them), `branched` (child and step), `accepted` (what was delivered, the review, any question answered), `abandoned` (why) |
| tags, reused, singletons checked | yes, on `opened` only | a package's topic does not change, and tags on every event would inflate the counts |
| check before acting (from the experiment log) | yes | before opening a package; an `abandoned` row is complete knowledge |
| a link column | no | the ID is the path |
| backfilled rows, counters | no | nothing predates the log |

One vocabulary across the three logs, so a single `rg '#<tag>' ai-sandbox/*/LOG.md` covers a topic.
Applied: the skeleton log preamble and a `Tags` column, `check.sh`'s tag frequencies reading the
third log, `session-start.md`'s search line covering every `LOG.md`, and `plan-implementation.md`'s
search-first step plus `accepted`-row contents. The root's log was regenerated, with the package's
`opened` row tagged. The bootstrap fixture row gained the column, and the gate passes.

**Links, the author's question.** Which records point at which was evaluated (see the dogfood
reply). Within packages, and from checkpoint to package, the links already existed. Missing were
the links from design, plan, attempt and review to sessions, a template field for `Unblocks:`, and
any way for a parent's step to wait on a branch: `check.sh` would have shown it `ready`. The rule
adopted is that links point backwards, are written once, by the later record, and are found
forwards by search. Two-way links would require editing closed records, the issue #3 failure. Built
and committed (`3517b1f`):

- `Sessions:` and `Unblocks:` on the design, `Session:` on plan, attempt and review;
- `Depends on:` may name a whole package, satisfied by its `accepted` row;
- `check.sh` checks that every link in an uncommitted record names something that exists;
- two bootstrap gates;
- the rule written into handbook §3 and both playbooks.

No session-record field was added: canonical step IDs make the forward links searchable.

**The design documented.** `docs/decisions/ADR-014-implementation-packages.md` was written with the
full decision, its alternatives and its consequences, and status `proposed`. It is uncommitted until
the author signs it off, since `docs/` changes are reviewed before they land.

**Design approved** by esdevop, 2026-10-26, as specified. `Approved by:` was filled, and `Sessions:`
and `Unblocks:` were added to the draft before approval.

**Dogfood finding 2: a gate wider than its step.** S-02's draft gate demanded *no FAIL anywhere* in
`bootstrap-test.sh`. S-03 edits a mechanism file, which makes the hash gate fail until S-04
regenerates the list. So S-02's gate would have passed or failed depending on whether the parallel
S-03 had run. It was corrected before release, to count only S-02's own `version label` failures.
`plan-implementation.md` step 3 gains the general form: a gate tests its own step, and whole-suite
gates belong on a final step that depends on all the others.


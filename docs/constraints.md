# rnd-project-memory — Constraints

**Updated:** 2026-08-17

> Hard limits the method must respect. A constraint here is binding: if it turns out
> negotiable, remove it rather than quietly working around it.

| Constraint | Type | Source | Notes |
|------------|------|--------|-------|
| Documentation and directory structure only — no tool, no dependencies | scope | `ADR-006` | Two executables ship: one advisory script, one blocking hook |
| The assistant must auto-load `AGENTS.md` and expand `@` imports | delivery | handbook §5 | Without both, every rule is inert and the failure is silent |
| No consumer has a git relationship to upstream | delivery | `ADR-003` | Rules out merge-based upgrades permanently |
| Public and MIT-licensed | legal | `ADR-005` | Nothing employer-identifying may enter the repository, including in history |
| Handbook and skeleton release under one tag | delivery | `ADR-004` | Every MAJOR must reconcile a 682-line document |
| No shared counter in any identifier | scope | handbook §4 | What makes adding a second contributor a no-op |

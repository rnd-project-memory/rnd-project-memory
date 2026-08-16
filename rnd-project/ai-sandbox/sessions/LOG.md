# <PROJECT_NAME> — Session Log

Append only. One row per session.

**Do not read this file in full — search it.** That is what it is for:

```bash
rg -i "<topic>" ai-sandbox/sessions/LOG.md
rg '#<tag>'     ai-sandbox/sessions/LOG.md
```

A hit gives you a session file; open that, not this log.

**Outcome names what was resolved**, not just what was worked on. Answered questions are
deleted from `OPEN_QUESTIONS.md`, so this row is the only cue a later reader gets that the
question ever had an answer.

**Tags:** reuse an existing tag if one fits — a topic spelled three ways over six months is
what makes search fail. `check.sh` prints tag frequencies; a singleton usually means a second
spelling of something already here.

| Date | Topic | Tags | Outcome | Link |
|------|-------|------|---------|------|

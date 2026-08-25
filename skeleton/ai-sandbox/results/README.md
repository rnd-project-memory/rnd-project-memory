Evidence cited from experiment records: `<what-was-done>__<YYYYMMDD>T<HHMMSS>Z.json`, created
once, never edited afterwards. Not raw data — counts, hashes, shares, anything that lets a
result be checked without re-running against data that may not still be there.

This is the committable half of §9's never-commit rule, and the two are one policy. Extracted data
does not enter the repository in any shape or size; a summary of it does, and lives here. A
project that has been committing small extracts is not looking at a gap in the ignore list — it is
looking at the file that was meant to replace them.

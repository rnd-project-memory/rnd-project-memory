# Credential patterns for this organisation, added to the ones .githooks/pre-commit ships with.
# One extended-regular-expression alternative per line. Blank lines and comments are ignored.
#
# This file is the profile layer: upstream never replaces it, and it is deliberately absent from
# the release hash list. It is read as data — the hook does not source it — so nothing here is
# executed, and a line that is not a valid regex is discarded with a warning rather than folded
# into the pattern the hook runs.
#
# Commit it. An organisation's patterns that live only on one machine are absent from every other
# clone, and their absence looks exactly like having none.
#
# The rule every line must satisfy: match a credential *value*, not the name of one. A pattern
# that fires on the word `password` also fires on documentation about passwords, and a blocking
# check that cries wolf is answered with --no-verify, after which it is dead while still
# appearing installed.
#
# Example, commented out:
# acme_tok_[A-Za-z0-9]{24,}

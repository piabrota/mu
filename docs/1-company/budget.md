---
title: Budget
status: draft
date: 2026-11-01
related: [charter.md, ../DECISION_MODELS.md]
style: direction
---

# Budget

What **piabrota itself** spends, and the caps that enforce it. The figures below came from Ouroboric
as starting values. piabrota has not decided them yet: a human confirms or changes them here. What
operators build with these tools is outside this page.

## Accounts

- Agentic routines may run on a developer's personal computer, on local models, at no API cost
  ([dogma 9](../../DOGMA.md)).
- Anthropic (Claude Code, the Claude API) and Kimi have first-class support. Each account and key
  belongs to piabrota or to the person who runs the routine, never to an employer.
- A token for an agent is created for that agent only, so it can be revoked without touching
  anything else.

## Caps

The `budget-cap` hard approval point enforces these defaults. A run that hits a cap stops with
everything resumable.

| Cap | Turns | Tokens | API spend |
| --- | --- | --- | --- |
| per run | 400 | 8M | $5 |
| per day | 1,000 | 20M | $10 |

## Keeping keys safe

- Keys and tokens live in a password manager and in an environment file outside every repository
  (for example `~/.config/piabrota/factory.env`, readable only by its owner). They never go into a
  repository, a chat, a ticket or a log.
- A key pasted into a chat stays in its transcript. A key committed to a public repository is copied
  by scanners within minutes, even if the commit is removed right after. `gitleaks` and GitHub push
  protection are there to catch mistakes, not to replace care.
- If a key leaks, revoke it first, then investigate.

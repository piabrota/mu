---
title: piabrota roadmap
status: draft
date: 2026-11-01
related: [charter.md, ../../DOGMA.md, ../DECISION_MODELS.md]
style: direction
---

# piabrota roadmap

This roadmap sets the order of work, not dates. Each product keeps its own detailed roadmap.

0. **The conversion:** this repo takes the piabrota identity, the dogma and the repo index.
1. **The GitHub setup:** create `piabrota-pr-bot`, add the `protect-main` ruleset to `mu`, and pass
   `scripts/check-repos.sh`.
2. **The handover to pirsig:** PARA, smart notes and the track record move from seed to daily use.
3. **The decision pipeline:** try the tracked [decision models](../DECISION_MODELS.md), then write the
   decision engine's first rules.
4. **Routines:** agents fix reported errors, on local models, Claude and Kimi.
5. **Later:** follow [Yggdrasil's roadmap](https://github.com/piabrota/yggdrasil/blob/main/docs/1-product/roadmap.md)
   from our fork, which mirrors upstream.

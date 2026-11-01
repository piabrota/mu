---
pirsig: note
zid: "7"
title: "Templates are rendered by minijinja-cli"
aliases: ["Templates are rendered by minijinja-cli"]
kind: permanent
tags: ["decision"]
created: 2026-11-01T07:14:51+00:00
updated: 2026-11-01T07:14:51+00:00
---

# Templates are rendered by minijinja-cli

**Decided 2026-11-01.** New components are Rust, rendered by minijinja-cli 3.0.1, which also renders PIABROTA.md. The Go component template is gone.

**Why:** piabrota is Rust first, and one engine serves both.

**Outcome:** pending.

Part of [[1 Decisions the track record|Decisions: the track record]].


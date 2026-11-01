---
title: Repositories
status: accepted
date: 2026-11-01
related: [../../PIABROTA.md, ../4-ways-of-working/docs-standard.md, charter.md]
style: reference
---

# Repositories

[PIABROTA.md](../../PIABROTA.md) indexes every public repo of the [`piabrota`](https://github.com/piabrota)
organisation. This page says how this repo's tree relates to them.

## Umbrellas

| Repository | Kind | Role |
| --- | --- | --- |
| [`mu`](https://github.com/piabrota/mu) | company umbrella | this repo: dogma, charter, standards, journal, brand; the products as submodules under [`products/`](../../products/) |
| [`yggdrasil`](https://github.com/piabrota/yggdrasil) | product umbrella | our fork of the agentic factory; it mirrors upstream |
| [`asgard`](https://github.com/piabrota/asgard) | product umbrella | our fork of the kickstart realm; it mirrors upstream |

## Upstream repos

Yggdrasil's leaves were not forked. They live in [`ouroboric-dev`](https://github.com/ouroboric-dev),
and the `ygg-*` scripts build them from there, so those links stay on upstream.

| Repository | Role |
| --- | --- |
| [`gungnir`](https://github.com/ouroboric-dev/gungnir) | the contract: interface types and JSON schemas |
| [`odin`](https://github.com/ouroboric-dev/odin) | the orchestrator: the graph engine and the `ygg` CLI |
| [`gleipnir`](https://github.com/ouroboric-dev/gleipnir) | the harness: agent adapters, the sandbox driver, policies and the check runner |
| [`jormungandr`](https://github.com/ouroboric-dev/jormungandr) | the loop: build, check and fix |
| [`havamal`](https://github.com/ouroboric-dev/havamal) | the skill library |
| [`voluspa`](https://github.com/ouroboric-dev/voluspa) | the graph library |
| [`midgard-react`](https://github.com/ouroboric-dev/midgard-react) | the Midgard realm's React flavour |
| [`helheim-go`](https://github.com/ouroboric-dev/helheim-go) | the Helheim realm's Go flavour |
| [`mimir`](https://github.com/ouroboric-dev/mimir) | the public benchmark kit |

## Clones

`check-repos.sh` expects the clones side by side in one folder: `mu`, `yggdrasil` (with its
submodules) and `asgard`. It checks a leaf or `mimir` only when that repo exists in the org.

---
title: Decision models
status: draft
date: 2026-11-01
related: [../DOGMA.md, 1-company/charter.md, 1-company/budget.md]
style: reference
---

# Decision models

This page tracks the decision models that piabrota can use, and where its agentic routines run.
[Dogma 3](../DOGMA.md) needs a decision model between an agent's output and the decision engine.

A decision model is not a chat model. It reads a state and a set of typed questions, and it returns
a calibrated probability for each answer. It generates no text.

Nothing here is evaluated yet. Every fact below comes from secondary sources read on 2026-11-01, so
treat it as unverified until a row has a date in **Tried**.

## Decision models

| Model | Maker | Runs on | What the sources say | Unverified points | Tried |
| --- | --- | --- | --- | --- | --- |
| [Jev](https://mastra.ai/articles/jev) | TypeSafe AI | hosted API | one call answers many typed questions, with a probability distribution and a confidence for each; trained to be calibrated (RLCD) | launched 2026-09-15; the implementation is not disclosed; independent benchmarks are thin | no |
| [Ollaya](https://github.com/ollaya-dev/ollaya/wiki) | ollaya-dev | a developer's computer | runs open decision models locally, as Ollama runs LLMs; a TypeSafe-compatible API; a router between language variants | the project's own docs were not read | no |
| [Ollama, decision models](https://docs.langchain4j.dev/integrations/decision-models/ollama) | Ollama | a developer's computer | runs Jev-style decision models locally, with no API key | about 91 ms per decision for a 9B model on an M5 Max, from one news item | no |
| [OpenAI Decisions API](https://www.eesel.ai/blog/openai-decisions-api) | OpenAI | hosted API | `POST /v1/decisions`, on `gpt-6-luna` only; answers are a probability, a fixed choice or an ordered score; at most 400 questions per request | $0.10 per million input tokens; about 150 ms; sources disagree on public beta or general availability, and on how the 10x speed claim was measured | no |

## Where routines run

| Where | For | Support | Notes |
| --- | --- | --- | --- |
| A developer's computer | routines and decision models with no API cost | Ollama, Ollaya | [`scripts/ygg-models.sh`](../scripts/ygg-models.sh) already serves local models through llama-server |
| Anthropic | agent work | first class: Claude Code, the Claude API | the scripts already run `claude` and take `AGENT:MODEL` roles |
| Kimi (Moonshot AI) | agent work | first class | guides report an Anthropic-compatible endpoint, `https://api.moonshot.ai/anthropic`, and the model Kimi K3. Check [the platform](https://platform.moonshot.ai) before you configure it |

No Anthropic or Kimi decision model is tracked yet.

## How to update this page

- Add a row when a model is worth a trial.
- Fill **Tried** with the date of a run, and link its result from the brain's track record.
- A trial must measure calibration: of the answers given at 90%, about 90% should be right.
- Move a fact out of **Unverified points** only when a primary source or a run confirms it.

## Sources

- [What is Jev and when to use it](https://mastra.ai/articles/jev)
- [What is Jev, Braintrust](https://www.braintrust.dev/articles/what-is-jev)
- [Ollaya setup and benchmarks](https://www.kunalganglani.com/blog/ollaya-ollama-decision-setup)
- [Ollama adds Jev-style decision models](https://alternativeto.net/news/2026/9/ollama-introduces-support-for-jev-style-decision-models-for-local-ai-processing/)
- [OpenAI's Decisions API vs Jev](https://www.firecrawl.dev/blog/openai-decisions-api-vs-jev)
- [OpenAI opens the Decisions API public beta](https://letsdatascience.com/news/openai-opens-decisions-api-public-beta-b69a1e40)
- [Using Kimi K3 with Claude Code](https://www.promptlayer.com/blog/how-to-use-kimi-k3-moonshot-ai-with-claude-code/)

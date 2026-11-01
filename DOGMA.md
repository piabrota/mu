# Dogma

The ten invariants of piabrota. They bind every repo, every person and every agent in the company.
When a document disagrees with this page, this page wins. Humans change it, through a pull request.

1. **Agents fix every error.** An error a user or an owner reports is a goal. An agent takes it and
   closes it as a short-sized goal: one pull request.
2. **No tests, unless proven.** Write a test only when it is a proven regression guardrail: it
   reproduces a failure that happened, it fails without the fix, and it passes with it.
3. **Judgement is decision-oriented.** Work is judged by a decision, never by an opinion:

   ```text
   agent output + evidence + definition of done
     -> decision model (structured decision)
     -> calibrated probabilities
     -> decision engine (rules that humans define, go or no-go)
     -> final verdict (an agentic decision)
   ```

4. **Humans own the rules.** Humans write the rules of the decision engine and approve direction.
   Agents decide inside those rules, and stop and ask outside them. Humans merge.
5. **The brain is the record.** The company is managed in [pirsig](https://github.com/piabrota/pirsig):
   smart notes, PARA, and a track record of every high-level decision with its outcome.
6. **Open and reproducible by default.** Every project is FOSS, in its own repository, with its own
   licence. The source is open, and so is the method. Rust comes first. Every plot is drawn with
   [archify](forks/archify) and every mockup with OpenPencil, from a source anyone can run again.
7. **Credit what we take.** Read before you borrow. Reuse work only as its licence allows, and keep
   its notices. A partner's name and logo stay theirs.
8. **Guardrails only get stronger.** Never weaken an approval point, a sandbox, a policy or a ruleset.
   Never read, print or store a secret.
9. **Routines run anywhere.** An agentic routine may run on a developer's personal computer, on local
   models (Ollama, Ollaya). Anthropic has first-class support (Claude Code, the Claude API), and so
   does Kimi. [Decision models](docs/DECISION_MODELS.md) are tracked in one page.
10. **Prod may break, for now.** Breaking prod is not a problem, as long as it can be
    fixed quickly. What counts is the time to fix, not the number of breaks.

OpenCode Agent Guide
====================

Goal
----
Create an "OpenCode" agent for this repository that assists with writing the thesis. The agent runs in your environment (or in CI), has explicit rules about what it can change, and uses the repository as context.

Overview / approach
-------------------
1. Design the agent persona and strict rules (scope, file access, commit behaviour).
2. Create a small agent manifest (template in .opencode/agent.yml) that lists intents, files it can read/write, and allowed shell commands.
3. Provide prompt templates and example tasks so the agent behaves consistently.
4. Run the agent locally (recommended) using your preferred chat/LLM runner, or integrate into CI (careful: require approvals before pushing).

Files added
-----------
- .opencode/agent.yml  — a template manifest you should edit to match your exact rules and credentials.
- docs/OPENCODE_AGENT.md — this document (how to design and use the agent).
- tools/agent/README.md — quick run & safety notes.

Agent design checklist
----------------------
1. Persona / Context:
   - Name: ThesisAssistant (example)
   - Role: pragmatic senior technical writer + LaTeX/pandoc engineer.
   - Project context: point to this repository root and the intended canonical source (Markdown or LaTeX).

2. Scope and allowed actions (be explicit):
   - Read: all files under content/, latex/, tools/, docs/ and any config files.
   - Write: only content/ (Markdown chapters), docs/ (guides), and commit metadata files. Optionally write latex/ if you accept generated LaTeX.
   - Do NOT modify: .git/*, secrets files, CI credentials, or unrelated top-level project files unless explicitly approved.
   - Commands allowed: file reads/writes, run local build scripts (latex/build.sh), run tests. No network calls unless explicitly configured.

Additional project-specific rules
---------------------------------
- Always read through all files under content/ before making any edits and ensure there are no contradictions across chapters.
- When working on chapters 03 (methodology) or 04 (results), summarize related Handbook chapters contributed by Maria Jover or Sergio Gimenez when they are relevant to hardware scope. The agent may read the handbook repository at /home/mj/Community-Network-Handbook on the develop branch for up-to-date reference material.
- Workflow enforcement: the agent must present a compact plan (targets, create/update status, assumptions/open questions) and wait for explicit approval before making edits. If the agent is invoked with a subtask or command that is not marked PLAN-ONLY, treat the invocation as approval.
- The agent may consult web search for factual validation and should reference /home/mj/Downloads/main.pdf (partner thesis) for cross-checks; avoid copying text verbatim unless allowed.

3. Commit & Git policy:
   - Agent should stage changes in a single commit per logical change.
   - Commit message must follow project convention: prefix scope (e.g. "thesis(md): fix abstract wording") and explain why.
   - Do NOT force-push. If history rewriting is needed, create a branch and request manual review.
   - Never commit secrets or files matching .gitignore (unless explicitly requested).

4. Interaction style and prompts
   - Provide a short system prompt file with persona + rules (example in .opencode/agent.yml).
   - For each task, include: intent, files to read, files to update (pattern), and acceptance criteria (tests or build commands to run).

Execution patterns
------------------
- Local, interactive: run the agent harness/your LLM client with the manifest and allow it to propose changes, then review and accept.
- Automated (CI): run agent in a sandbox branch, create a PR with suggested changes and a detailed explanation. A human reviews before merging.

Example task flow (writing a chapter)
1. You ask the agent: "Draft or improve the Introduction to 600–800 words, include motivation, objectives, and 3 citations from bibliography." Provide any constraints.
2. The agent:
   - Reads content/01-introduction.md and latex/pandoc-header.tex
   - Edits content/01-introduction.md (only) and runs pandoc build script to verify PDF generation.
   - If build succeeds and acceptance criteria met, prepares a commit with clear message and shows a diff.
3. You review the diff locally and approve commit.

Safety & best-practices
-----------------------
- Keep the manifest conservative; prefer the agent propose edits rather than perform destructive actions.
- Always require a human review before pushes to main.
- Keep backups (tag or branch) before large automated changes.

Where to go next
-----------------
1. Edit .opencode/agent.yml with the persona and exact file rules you want.
2. Choose how you will run the agent: locally (manual review) or CI (PR flow).
3. If you want, I can generate a concrete system prompt and example run script that launches an LLM call using your API key (I will not store or run with secrets). Tell me how you'd like to run it and I will prepare the files.

---
Timestamp: 2026-05-04

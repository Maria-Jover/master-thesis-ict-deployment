Agent runner notes
===================

This folder contains helper information for running an OpenCode-style agent locally.

Quick start suggestions
-----------------------
1. Edit .opencode/agent.yml to match your exact security and workflow preferences.
2. Choose an LLM runner/harness (your local CLI, LangChain, or the OpenAI/Anthropic client you prefer).
3. Construct the system prompt from .opencode/agent.yml: persona.system_prompt and scope rules.
4. For each task, send a structured prompt: intent, files-to-read, files-to-write, acceptance criteria.

Local CLI (thesisassistant)
---------------------------
Run the local agent CLI we added to this repo:

  ./tools/agent/agent_cli.sh "@thesisassistant PLAN-ONLY: Review chapter 01"

Behavior:
- Generates a compact plan and prints it. If PLAN-ONLY is present it exits after printing the plan.
- If not PLAN-ONLY, it asks for explicit approval and then creates a branch thesisassistant/<timestamp>/plan and commits a placeholder file.
- You should replace the placeholder LLM call with your preferred integration (the script is intentionally minimal and safe).

Security:
- No secrets or network calls are performed by default. The CLI scaffolds a branch and commits locally only.


Safety
------
- Always run agents in a workspace where you can easily inspect diffs before committing or pushing.
- The default manifest disallows network calls and pushing to remote. If you change that, understand the security implications.

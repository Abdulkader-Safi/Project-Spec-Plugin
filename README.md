# Project spec

A plugin for Claude Code and Claude Cowork. It turns a project idea into six planning files, one stage at a time, each signed off before the next:

```
spec/
  01-product.md
  02-users.md
  03-requirements.md
  04-tech-decisions.md
  05-tech-requirements.md
  06-build-spec.md
```

The sixth file is self-contained. Claude Code builds from it alone. The other five are the reasoning behind it.

## Install in Claude Code

```
/plugin marketplace add Abdulkader-Safi/Project-Spec-Plugin
/plugin install project-spec@project-spec
```

## Install in Claude Cowork

Build the plugin file, then drag `project-spec.plugin` into a Cowork chat and accept it:

```bash
./build.sh
```

## Use

Describe what you want to build ("I want to build a booking tool for clinics", "write a PRD for X"), or run `/project-spec:project-spec`.

Claude asks a few questions per stage, drafts the file and waits for your OK. Say "just draft them" to get stages 01 to 05 in one pass with every default marked as an open question.

In a code repo the files go in `docs/spec/`. Elsewhere Claude follows the workspace's own rules for project folders, or asks.

When 06 is signed off, start Claude Code in the repo with:

```
Read docs/spec/06-build-spec.md and build it, starting with M0. Follow section 13.
```

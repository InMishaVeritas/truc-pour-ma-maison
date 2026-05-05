# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This repo manages Gmail filters as code using [gmailctl](https://github.com/mbrt/gmailctl), which compiles Jsonnet configs into Gmail filter rules and applies them via the Gmail API.

All filter logic lives under `gmail-filters/`. The Makefile wraps `gmailctl` commands and assumes credentials are already set up at `~/.gmailctl/`.

## Commands

All commands run from `gmail-filters/`:

```bash
make test    # Run filter unit tests (no Gmail auth needed)
make diff    # Preview what would change in Gmail (requires auth)
make apply   # Push config to Gmail (requires auth)
make backup  # Snapshot current Gmail state before making changes
make debug   # Show the fully expanded Jsonnet config
```

First-time setup:
```bash
brew install gmailctl
gmailctl init   # OAuth flow — creates ~/.gmailctl/credentials.json
```

## Architecture

`config.jsonnet` is the entrypoint. It imports three libs and assembles an ordered list of rules:

- **`lib/senders.libsonnet`** — pure data: maps category names to `{ or: [{from: ...}] }` filter objects
- **`lib/labels.libsonnet`** — flat list of all Gmail labels to manage (nested via `Parent/Child` names)
- **`lib/helpers.libsonnet`** — four rule-builder functions (`labelFrom`, `labelAndArchive`, `labelAndStar`, `silentLabel`) that each return a `{ filter, actions }` rule object

Rule ordering matters: security/anti-phishing rules run first (before any labeling), then Work, Dev, Finance, Receipts, Newsletters, Notifications, Personal.

## Adding rules

For a new sender in an existing category: add it to the relevant `{ or: [...] }` block in `lib/senders.libsonnet`. The `helpers.*` call in `config.jsonnet` picks it up automatically.

For a new category: add labels to `lib/labels.libsonnet`, a sender block to `lib/senders.libsonnet`, and a rule in `config.jsonnet` using the appropriate helper.

## CI

`.github/workflows/gmailctl-validate.yml` runs on PRs touching `gmail-filters/`. It installs gmailctl, compiles the config (`gmailctl debug`), and runs the test suite (`gmailctl test`) — no Gmail credentials required in CI.
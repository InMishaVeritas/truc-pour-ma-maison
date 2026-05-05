# gmail-filters

Gmail filters as code, managed with [gmailctl](https://github.com/mbrt/gmailctl).

## Structure

```
gmail-filters/
├── config.jsonnet          # Entrypoint: all rules
├── lib/
│   ├── senders.libsonnet   # Sender lists per category (data only)
│   ├── labels.libsonnet    # Label taxonomy
│   └── helpers.libsonnet   # Reusable rule builders
├── tests/
│   └── filters_test.jsonnet
├── Makefile
└── .github/workflows/      # CI validation on PRs
```

## Quickstart

```bash
# 1. Install
brew install gmailctl    # or: go install github.com/mbrt/gmailctl/cmd/gmailctl@latest

# 2. First-time auth (creates ~/.gmailctl/credentials.json)
gmailctl init

# 3. ALWAYS back up your existing Gmail filters first
make backup

# 4. Update config.jsonnet — set your email in the `author` block

# 5. See what would change
make diff

# 6. Apply
make apply
```

## Common commands

| Command       | What it does                                    |
|---------------|-------------------------------------------------|
| `make diff`   | Preview pending changes vs Gmail (dry-run)      |
| `make apply`  | Push local config to Gmail                      |
| `make test`   | Run filter tests in `tests/`                    |
| `make debug`  | Show fully expanded config                      |
| `make backup` | Snapshot current Gmail state to `backups/`      |
| `make edit`   | Interactive edit-and-apply mode                 |

## Adding a new rule

Most of the time you just need to **add a sender to `lib/senders.libsonnet`**.
The existing `helpers.labelFrom(...)` calls in `config.jsonnet` will pick it up.

For a brand-new category:

1. Add label(s) to `lib/labels.libsonnet`
2. Add sender list to `lib/senders.libsonnet`
3. Add a rule in `config.jsonnet`, ideally using a helper

## Anti-phishing rules

The first block of `config.jsonnet` catches:
- Mail claiming to be from major brands (PayPal, banks, impôts...) but
  failing both SPF and DKIM
- Look-alike domains (paypa1, amaz0n, etc.)

These run **before** any labeling rule, so phishing gets sent to spam
before any label is applied.

## Caveat: existing messages

`gmailctl apply` only affects **new** mail. To apply rules to your existing
inbox, use Gmail's UI:
- Settings → Filters → Import filters → upload `gmailctl export > filters.xml`
- Tick "Apply new filters to existing email"

## Multiple accounts

Use a separate config dir per account:

```bash
alias gmailctl-perso='gmailctl --config-dir=$HOME/.gmailctl-perso'
alias gmailctl-pro='gmailctl --config-dir=$HOME/.gmailctl-pro'
```

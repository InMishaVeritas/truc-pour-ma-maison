// Gmail filters as code — entrypoint
// Apply with: make apply
// Diff with:  make diff

local lib = import 'gmailctl.libsonnet';
local senders = import 'lib/senders.libsonnet';
local labels = import 'lib/labels.libsonnet';
local helpers = import 'lib/helpers.libsonnet';

{
  version: 'v1alpha3',
  author: {
    name: 'Michel',
    email: 'amoussoumichel90@gmail.com',  // <-- remplace
  },

  // Labels managed by gmailctl. If a label already exists in Gmail with the
  // same name, it is reused. Removing one here will NOT delete it from Gmail
  // unless you also pass --remove-labels at apply time.
  labels: labels.all,

  rules: [
    // ─────────────────────────────────────────────────────────────
    // 1. SECURITY / ANTI-PHISHING (runs first, most aggressive)
    // ─────────────────────────────────────────────────────────────

    // Hard bounce: SPF + DKIM both failing on a "real-looking" sender
    // (Gmail already filters most, this catches edge cases)
    {
      filter: {
        and: [
          { query: 'has:nouserlabels' },
          { query: '-{dkim:pass spf:pass}' },
          { or: [
            { from: 'paypal' },
            { from: 'amazon' },
            { from: 'apple' },
            { from: 'microsoft' },
            { from: 'google' },
            { from: 'banque' },
            { from: 'impots' },
          ] },
        ],
      },
      actions: { delete: true },
    },

    // Suspicious lookalike domains (paypa1, amaz0n, etc.)
    {
      filter: {
        or: [
          { from: 'paypa1' },
          { from: 'amaz0n' },
          { from: 'g00gle' },
          { from: 'micros0ft' },
          { from: 'app1e' },
        ],
      },
      actions: { delete: true },
    },

    // ─────────────────────────────────────────────────────────────
    // 2. WORK — Octo / Accenture
    // ─────────────────────────────────────────────────────────────

    helpers.labelFrom(senders.work.octo, 'Work/Octo'),
    helpers.labelFrom(senders.work.syndicat, 'Work/Syndicat'),
    // helpers.labelFrom(senders.work.clients, 'Work/Clients'),  // uncomment when client domains are added

    // Calendar invites → Meetings (don't archive, you need to see them)
    {
      filter: {
        and: [
          { query: 'filename:invite.ics OR filename:event.ics' },
        ],
      },
      actions: {
        labels: ['Work/Meetings'],
        markImportant: true,
      },
    },

    // ─────────────────────────────────────────────────────────────
    // 3. DEV — GitHub, Scaleway, CI/CD
    // ─────────────────────────────────────────────────────────────

    // GitHub: label everything, but only inbox the @mentions/review-requested
    {
      filter: { from: 'noreply@github.com' },
      actions: { labels: ['Dev/GitHub'] },
    },
    {
      filter: {
        and: [
          { from: 'noreply@github.com' },
          { or: [
            { query: '"mentioned you"' },
            { query: '"review requested"' },
            { query: '"requested your review"' },
            { query: '"assigned"' },
          ] },
        ],
      },
      actions: {
        labels: ['Dev/GitHub'],
        markImportant: true,
      },
    },
    // Auto-archive GitHub noise (subscribed/notifications you don't need to see)
    {
      filter: {
        and: [
          { from: 'noreply@github.com' },
          { query: 'list:subscribed' },
          { not: { or: [
            { query: '"mentioned you"' },
            { query: '"review requested"' },
          ] } },
        ],
      },
      actions: { archive: true, labels: ['Dev/GitHub'] },
    },

    helpers.labelFrom(senders.dev.scaleway, 'Dev/Scaleway'),
    helpers.labelFrom(senders.dev.cicd, 'Dev/CI-CD'),

    // ─────────────────────────────────────────────────────────────
    // 4. FINANCE — banks, invoices
    // ─────────────────────────────────────────────────────────────

    {
      filter: senders.finance.banks,
      actions: {
        labels: ['Finance/Banque'],
        markImportant: true,
      },
    },
    helpers.labelFrom(senders.factures, 'Finance/Factures'),
    {
      filter: {
        and: [
          { or: [
            { query: 'subject:facture' },
            { query: 'subject:invoice' },
            { query: 'subject:"votre re\u00e7u"' },
          ] },
          { has: 'attachment' },
        ],
      },
      actions: { labels: ['Finance/Factures'] },
    },

    // ─────────────────────────────────────────────────────────────
    // 5. RECEIPTS — order confirmations, shipping
    // ─────────────────────────────────────────────────────────────

    helpers.labelFrom(senders.receipts, 'Receipts'),
    {
      filter: {
        or: [
          { query: 'subject:"order confirmation"' },
          { query: 'subject:"confirmation de commande"' },
          { query: 'subject:"votre commande"' },
          { query: 'subject:"shipped"' },
          { query: 'subject:"exp\u00e9di\u00e9"' },
        ],
      },
      actions: { labels: ['Receipts'] },
    },

    // ─────────────────────────────────────────────────────────────
    // 6. NEWSLETTERS — tech vs marketing
    // ─────────────────────────────────────────────────────────────

    helpers.labelAndArchive(senders.newsletters.tech, 'Newsletters/Tech'),
    // helpers.labelAndArchive(senders.newsletters.marketing, 'Newsletters/Marketing'),  // uncomment when explicit senders are added

    // Catch-all newsletter detection: List-Unsubscribe header + not already labeled
    {
      filter: {
        and: [
          { query: 'list:(*)' },
          { query: '-label:Work -label:Dev -label:Finance' },
        ],
      },
      actions: {
        labels: ['Newsletters/Marketing'],
        archive: true,
      },
    },

    // ─────────────────────────────────────────────────────────────
    // 7. NOTIFICATIONS — automated alerts (low priority)
    // ─────────────────────────────────────────────────────────────

    helpers.labelFrom(senders.admin, 'Admin'),
    helpers.labelAndArchive(senders.notifications.all, 'Notifications'),

    // ─────────────────────────────────────────────────────────────
    // 8. PERSONAL — family, travel
    // ─────────────────────────────────────────────────────────────

    helpers.labelAndStar(senders.personal.family, 'Personal/Family'),  // uncomment when family addresses are added
    helpers.labelFrom(senders.personal.house, 'Personal/House'),
    helpers.labelFrom(senders.personal.travel, 'Personal/Travel'),
    helpers.labelFrom(senders.personal.health, 'Personal/Health'),
   helpers.labelFrom(senders.personal.fun, 'Personal/Fun'),
  ],
}

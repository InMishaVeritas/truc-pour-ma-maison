// Reusable filter-building helpers.
// Each one returns a complete rule object { filter, actions }.

{
  // Just apply a label, keep in inbox
  labelFrom(senderFilter, labelName):: {
    filter: senderFilter,
    actions: { labels: [labelName] },
  },

  // Apply a label AND archive (skip inbox) — for low-priority stuff
  labelAndArchive(senderFilter, labelName):: {
    filter: senderFilter,
    actions: {
      labels: [labelName],
      archive: true,
    },
  },

  // Apply a label and star — for important personal mail
  labelAndStar(senderFilter, labelName):: {
    filter: senderFilter,
    actions: {
      labels: [labelName],
      star: true,
      markImportant: true,
    },
  },

  // Apply a label, archive, and mark read — the "fire and forget" pattern
  // Useful for monitoring alerts you only want to keep for archaeology
  silentLabel(senderFilter, labelName):: {
    filter: senderFilter,
    actions: {
      labels: [labelName],
      archive: true,
      markRead: true,
    },
  },
}

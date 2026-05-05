// Label taxonomy. gmailctl will create these in Gmail on apply.
// Nested labels use "Parent/Child" notation.

{
  all: [
    { name: 'Work' },
    { name: 'Work/Octo' },
    { name: 'Work/Clients' },
    { name: 'Work/Meetings' },
    { name: 'Work/Syndicat' },

    { name: 'Dev' },
    { name: 'Dev/GitHub' },
    { name: 'Dev/Scaleway' },
    { name: 'Dev/CI-CD' },

    { name: 'Finance' },
    { name: 'Finance/Banque' },
    { name: 'Finance/Factures' },

    { name: 'Receipts' },

    { name: 'Newsletters' },
    { name: 'Newsletters/Tech' },
    { name: 'Newsletters/Marketing' },

    { name: 'Admin' },

    { name: 'Notifications' },

    { name: 'Personal' },
    { name: 'Personal/Family' },
    { name: 'Personal/Travel' },
    { name: 'Personal/Health' },
    { name: 'Personal/House' },
    { name: 'Personal/Fun' },
  ],
}

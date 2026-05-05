// gmailctl tests — verify that a sample message would match the right rule.
// Run with: gmailctl test
// Each test asserts that a given message hits a given set of labels/actions.

local config = import '../config.jsonnet';

{
  version: 'v1alpha3',
  tests: [
    {
      name: 'GitHub mention should be marked important',
      messages: [{
        from: 'noreply@github.com',
        subject: 'You were mentioned in PR #123',
        body: 'mentioned you in repo/foo#123',
      }],
      actions: {
        labels: ['Dev/GitHub'],
        markImportant: true,
      },
    },
    {
      name: 'GitHub subscribed notification should be archived',
      messages: [{
        from: 'noreply@github.com',
        subject: 'Re: [foo/bar] Some PR',
        headers: { 'List-Id': 'foo.bar.github.com' },
        body: 'subscribed',
      }],
      actions: {
        labels: ['Dev/GitHub'],
        archive: true,
      },
    },
    {
      name: 'Scaleway alert lands in Dev/Scaleway',
      messages: [{
        from: 'no-reply@scaleway.com',
        subject: 'Instance restart notification',
      }],
      actions: {
        labels: ['Dev/Scaleway'],
      },
    },
    {
      name: 'Boursobank mail goes to Finance/Banque + important',
      messages: [{
        from: 'service@boursobank.com',
        subject: 'Votre relevé est disponible',
      }],
      actions: {
        labels: ['Finance/Banque'],
        markImportant: true,
      },
    },
  ],
}

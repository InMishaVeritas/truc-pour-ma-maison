// All sender lists in one place — pure data, no logic.
// Each entry can be a domain ("@github.com") or a full address.
// Use { or: [...] } objects so they can be passed directly as filters.

{
  work: {
    octo: { or: [
      { from: '@octo.com' },
      { from: '@accenture.com' },

    ] },
    clients: { or: [
      // Add your client domains here
      // { from: '@client-a.com' },
    ] },
    syndicat: { or: [
      { from: 'solidairesinformatique.org' },
    ] },
  },

  dev: {
    scaleway: { or: [
      { from: '@scaleway.com' },
      { from: '@scw.cloud' },
      { from: '@scaleway.net' }
    ] },
    cicd: { or: [
      { from: 'noreply@circleci.com' },
      { from: 'builds@travis-ci.com' },
      { from: 'noreply@gitlab.com' },
      { from: 'notifications@dependabot.com' },
    ] },
  },

  finance: {
    // French banks + common SaaS finance senders
    banks: { or: [
      { from: 'ca-briepicardie.fr' },
      { from: '@communications.socgen.com' },
      { from: '@notificationsclients.socgen.com' },
      { from: '@bnpparibas' },
      { from: '@labanquepostale.fr' },
      { from: '@info.epsor.fr' },
      { from: '@revolut.com' },
      { from: '@qonto.com' },
      { from: '@wise.com' },
    ] },
  },

  newsletters: {
    tech: { or: [
      { from: '@tldrnewsletter.com' },
      { from: '@bytebytego.com' },
      { from: '@pragmaticengineer.com' },
      { from: '@thenewstack.io' },
      { from: '@hackernewsletter.com' },
      { from: '@kubeweekly.io' },
      { from: '@devopsweekly.com' },
    ] },
    marketing: { or: [
      // Will mostly be caught by the List-Unsubscribe rule.
      // Add explicit ones here if you want them archived without the catch-all.
    ] },
  },

  admin: { or: [
    { from: '@impots.gouv.fr' },
    { from: '@dgfip.finances.gouv.fr' },
    { from: '@caf.fr' },
    { from: '@ameli.fr' },
    { from: '@francetravail.fr' },
    { from: 'service-public.fr' },
    { from: 'monespacesante' },
  ] },

  notifications: {
    all: { or: [
      { from: 'no-reply@' },
      { from: 'noreply@' },
      { from: 'donotreply@' },
      { from: 'notifications@' },
      { from: 'alerts@' },
    ] },
  },

  factures: { or: [
    { from: 'mint-energie.com' },
    { from: 'billing@'},
    { from: 'sales@jetbrains.com'},

  ] },

  receipts: { or: [
    { from: 'order-update@amazon' },
    { from: 'auto-confirm@amazon' },
    { from: '@dndbeyond.com' },
    { from: 'ma-commande@fnac.com'},
    { from: '@chronopost.fr'},
    { from: '@stripe.com'},
    { from: '@stripe.com'},
    { from: 'billing@jetbrains.com' },
    { from: 'ticket'}

  ] },

  personal: {
    family: { or: [
      { from: 'anh.boutin@gmail.com' },
      { from: 'amoussoumichel90@gmail.com' },
    ] },
    travel: { or: [
      { from: '@booking.com' },
      { from: '@airbnb.com' },
      { from: '@sncf-connect.com' },
      { from: '@oui.sncf' },
      { from: '@airfrance.fr' },
      { from: '@blablacar.com' },
      { from: 'ouigo.com' },
    ] },
    house: { or: [
      { from: '@cogedim.com' },
      { from: 'cardif.fr' },

    ] },
    health: { or: [
      { from: '@ipsosante.fr' },
      { from: '@cerballiance.fr' },
      { from: 'doctolib.com' },
      { from: 'argos-veterinaire.com' },
    ] },
   fun: { or: [
        { from: '@cineoffice.fr' },
      ] },
  },
}

# Internet International Bank Account Number (IIBAN)

IIBAN or Internet IBAN (International Bank Account Number) provides a mechanism for the identification of internet connected financial endpoints.

IIBAN is decentralized, internet-focused extension of the European Union's successful International Bank Account Number (IBAN) standard.

## Status

 * __Publication status__: Published.


## Features

 * __Short and fixed length__: An IIBAN is only 16 characters long.  For example `AA110011123Z5678`.
 * __Human friendly__: A European Committee for Banking Standards (ECBS) compliant human-friendly format is also defined to aid in transcription.  In this way, IIBAN differs from its parent IBAN standard, which does not encourage ECBS-compliant human identifiers. For example `AA11 0011 123Z 5678`.
 * __Single case__: IIBAN only allows single case letters.  This reduces ambiguity by discouraging the use of lower case presentation that may result in ambiguity (the letter 'l' and the number '1'), and makes the standard more accessible in parts of the world that do not normally make extensive use of the Roman alphabet.  In this way, IIBAN differs from its parent IBAN standard, which for presumably historic reasons allows the specification of both upper and lower case letters as part of an account identifier.
 * __Democratic namespace allocation__: Traditional financial networks require recognition of a nation state in order to acquire a two letter ISO country code.  Following this recognition, they also require the establishment of a formally registered banking entity within the country in question.  In practice, it is often extremely difficult for new businesses or individuals to obtain the right to issue accounts under such an identifier, and these are the only accounts that will be recognized by other banks.  IIBAN encourages the democratic allocation of account issuing rights to any applying party and therefore encourages financial innovation.  In this way, IIBAN differs from its parent IBAN standard, which fails to segregate traditional regulatory concerns for financial service provider oversight from the ability for newcomers and innovators to issue accounts.
 * __Transcription error correction__: IIBAN provides a transcription error correction path that is very effective.
 * __Features Inherited from IBAN__
   * __Transcription error detection__: A two digit compulsory checksum algorithm allows systems to detect transcription errors and prompt the user for a correction before creating potentially expensive transaction level manual intervention and support requirements.
   * __Simple interoperability__: Because the IBAN standard is based upon fixed length identifiers associated with a limited number of 'country'-level prefixes, and because IIBAN assumes the AA 'country'-level prefix for the internet, technical barriers to the integration of IIBAN in to existing systems that support IBAN are reduced.
   * __Familiar__ End users who are familiar with the IBAN standard (Europe, some other countries) will be comfortable with the structure of the IIBAN.  This reduces novelty and friction of uptake.
  
## Structure of an IIBAN

An IIBAN is made up from the same components as the European Union's successful ISO1383 IBAN standard: country, checksum and account specifier.  Similar to bank identification within the IBAN system, to facilitate the democratic allocation of segments of the IIBAN address space to the global community of innovators, IIBAN includes and institution identifier as part of the account standard.  These segments can be seen as the individual sections of a human format IIBAN:

`AA11 0011 123Z 5678`

 * __Country__: IIBAN adopts the nominal country of `AA` to represent 'The Internet'.
 * __Checksum__: IIBAN inherits the two digital checksum from the IBAN standard.  In the example, this is `11`.
 * __Institution__: IIBAN makes use of a four digit institution identifier to aid in the distribution of portions of the IIBAN namespace.  In the example, the institution is `0011`.
 * __Institution-local Account__: The remnant six characters of an IIBAN make up the institution-local account specifier.  In the example, this is `123Z5678`.

## IIBAN for Innovators

If your business maintains partner or customer balances, provides market or currency exchange services or holding accounts for private or generally traded financial instruments, currencies or assets, then you can benefit from IIBAN.

 * __Standardized financial endpoint identification__: The use of IIBAN means that customers in Europe and an increasing number of other countries are already familiar with your identifier format.
 * __Transcription error detection__: Easily detect and suggest corrections for erroneous input - before it raises costly support issues requiring manual intervention.
 * __Integration potential__: With an increasing number of financial systems adopting the IBAN standard, IIBAN puts you in an excellent position for integration with third party financial service providers and settlement services.
 * __Outlive specific settlement networks__: By switching your primary account identifier from one that is linked to the settlement network(s) upon which your customers are performing transactions, you ensure that your systems (and customers!) can outlive any specific settlement network.

## Implementations

 * PHP
   * The [php-iban](https://github.com/globalcitizen/php-iban) project supports the validation of IIBAN, including transcription error recovery.

## Revisions

 * 2013-05-16: [draft-stanish-iiban-01](http://tools.ietf.org/html/draft-stanish-iiban-01): Integrate feedback and update ABNF formal definition.
 * 2012-11-13: [draft-stanish-iiban-00](http://tools.ietf.org/html/draft-stanish-iiban-00): Significant update including format modifications.
 * 2012-04-13: [draft-iiban-01](http://tools.ietf.org/html/draft-iiban-01): Various changes including initial registry contents and a transcription error recovery table.
 * 2011-11-15: [draft-iiban-00](http://tools.ietf.org/html/draft-iiban-00): Initial release.

## History

Original work toward publication was performed by Walter Stanish and sponsored by Payward Inc. (Kraken).

Later work porting to Github was performed by Walter Stanish independently.

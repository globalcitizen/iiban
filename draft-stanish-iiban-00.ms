.\"
.\"
.\"     David M. Meyer
.\"     dmm@1-4-5.net
.\"     
.\"     
.\"     Fill in Author?, -abc, category, ...
.\"
.\"
.\"     $Header: /home/dmm/SDOs/IETF/Drafts/generic_draft/RCS/draft-ietf-abc.ms,v 1.19 2004/09/28 13:50:35 dmm Exp $
.\"
.\"
.\"
.so tmac.id
.tl 'INTERNET-DRAFT''Walter Stanish'
.tl 'Intended status: Experimental''The IFEX Project'
.tl 'Obsoletes: draft-iiban-01''ifex-project.org'
.tl 'Expires: \*[*XP]''\*(MO \n[*xyear]'
.LP
.ce 2
Internet International Bank Account Number (IIBAN)
draft-stanish-iiban-00

.LP
.B Abstract
.LP
.in 3

An Internet IBAN (IIBAN) identifies an internet-based financial endpoint in
a manner that is superset-compatible with the existing European Committee 
for Banking Standards (ECBS) International Bank Account Number (IBAN) standard
[ISO13616] and implementation recommendations [ECBS].  This document obsoletes
draft-iiban-01.

.IDBOILER "i"

.COPYSTATEMENT

.LP
.KS

.LP
.MH 1 Introduction
.LP
.in 3

An Internet IBAN (IIBAN) identifies an internet-based financial endpoint.
No assumptions are made about settlement paths, currencies or commodities
being exchanged, or trust relationships between parties.  IIBAN provides a
building block with which the internet community can develop viable, 
interoperable alternatives to legacy financial systems.

Technically, IIBAN is an unofficial superset of the European Committee for
Banking Standards (ECBS) International Bank Acccount Number (IBAN) standard
[ISO13616] that is increasingly used in conventional global financial
networks, including outside of its original home of Europe.  Against the
IBAN registry [IBAN-REG], IIBAN subsumes the position of National Numbering 
Authority (NNA) for the nominal [ISO3166] 'nation' of AA (the Internet)
in order to provide a financial endpoint registrar service for the internet
community.

.RFC2119

.KE
.LP
.bp
.TOCP
.bp

.LP
.MH 1 Requirement
.LP
.in 3

In recent years the internet has seen the emergence of an increasing
variety of online financial settlement scenarios.  Such scenarios
include web based commerce, high frequency trading (HFT) on stock
markets, mobile phone 'in app' payments, mobile near field 
communication (NFC) physical proximity-based payments, online 
banking based bill payment, and interpersonal payments within
Massive Multiplayer Online Roleplaying Games (MMORPGs), amongst
others.  These scenarios vary in at least the following aspects:

 * Typical payment size

 * Acceptable settlement latency

 * Currencies or commodities supported

 * Nature of trust relationships between parties (if any)

 * Requirement for offline operations

Despite these differences, in each case the need remains to 
precisely identify each of the parties within a transaction.

Given this trend, it makes sense to propose a standard mechanism
for the consistent, global identification of internet-based
financial endpoints.  IIBAN provides such a mechanism.

.LP
.MH 1 "Solution"
.MH 2 "ISO13616 (IBAN)"
.LP
.in 3

For inspiration we look toward emerging standards for
international financial endpoint identification in 
conventional financial networks.  Today's most widely
adopted international standard in this area is
the European Committee for Banking Standards (ECBS)'
IBAN [ISO13616], which builds upon the ISO's 2-character
country identification scheme [ISO3166].

The format of an IBAN is as follows:

 <ISO3166-1 alpha2 country> + <2 digit checksum> + <BBAN>


The checksum is calculated as follows:

 1. Set the checksum digits to '00'.

 2. Re-arrange the string such that the BBAN comes first, then
    the country code, and finally the '00' or blank checksum.

 3. Transpose the letters A-Z to the numbers 10-35, expanding
    the string as appropriate.

 4. Convert the string to an integer, ignoring leading zeros.

 5. Calculate the Mod-97 [ISO7064] checksum of the number.

 6. Subtract the checksum from 98 and, if necessary, pad with
    a leading 0 to make a two digit number.

The BBAN is a nation-specific 'Basic Bank Account Number' that must
be fixed length for any given nation but whose length may vary (to
a maximum of 30 characters) between nations.  National formats are 
specified by National Numbering Authorities (NNAs).
SWIFT's IBAN registry [IBAN-REG] aggregates each national
scheme in to the global IBAN standard.

.LP
.MH 2 "IIBAN"
.LP
.in 3

In order to issue financial endpoint identifiers within the IBAN [ISO13616]
scheme IANA assumes National Numbering Authority (NNA) or 'nation' status 
for the nominal nation of 'AA' (the Internet).

The IIBAN format may be expressed in ABNF [RFC5234] as follows:

 iiban        = iircc checksum bban         ; eg: AA110011123Z5678
 iircc        = iircc-aa                    ; IIBAN-reserved
                                            ; country code
 iircc-aa     = %d65.65                     ; ie. AA
 checksum     = 2digit                      ; eg: 12
 bban         = institution account         ; eg: INST123Z5678
 institution  = rsv-inst / std-inst         ; eg: 0010 or INST
 rsv-inst     = "00" 2char                  ; eg: 0010
 std-inst     = nonzerochar 3char / char nonzerochar 2char ; eg: INST
 account      = 8char                       ; eg: 123Z5678

 char         = digit / caps-letter
 digit        = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" /
                "9"

 caps-letter  = %d65 / %d66 / %d67 / %d68 / %d69 / %d70 / %d71 /
                %d72 / %d73 / %d74 / %d75 / %d76 / %d77 / %d78 /
                %d79 / %d80 / %d81 / %d82 / %d83 / %d84 / %d85 /
                %d86 / %d87 / %d88 / %d89 / %d90   ; ie. capital A-Z

 nonzerochar  = caps-letter / "1" / "2" / "3" / "4" / "5" / "6" /
                              "7" / "8" / "9"

An explanation of the major elements follows.

iiban:
  A structurally valid IIBAN.

iircc:
  IIBAN-reserved country code.  Initially "AA", though in future
  this MAY include one or more additional ISO 3166-1 alpha-2
  country codes subsumed by IANA for the expansion IIBAN namespace.

checksum:
  Two checksum digits as per the IBAN standard, the algorithm for
  which is described above.  These digits are used to detect 
  transposition errors, preventing accidental misrouting.

bban:
  The Basic Bank Account Number (BBAN) is the portion of an IBAN
  defined by a National Numbering Authority (NNA).  In our nominal
  nation of 'AA' (the Internet), the BBAN defines the structure of
  an internet-based financial endpoint as being comprised of a 
  four character institution code followed by an eight character 
  institution-specific endpoint identifier.

institution:
  The four character institution code identifies either a reserved
  portion of the name space or a registrant of 'institution' status.
  Four characters provides for a total of 1,679,616 institution 
  codes (36^4).  Reserved institution codes are those that begin
  with two zeros ('00'), whilst all other codes are available for
  IANA to assign to registrants.

.bp

  The following table defines reserved institution codes.
 
  +-----------+-------------------------------------------+
  | Code      | Purpose                                   |
  +-----------+-------------------------------------------+
  | 0000-0009 | (Reserved for future use)                 |
  | 0010      | Private Use (eg. IPv4 10.x.x.x [RFC1918]) |
  | 0011      | Documentation, public works of fiction    |
  | 0012-00ZZ | (Reserved for future use)                 |
  +-----------+-------------------------------------------+ 
   
account:
  An eight character, institution-specific, 
  institution-assigned endpoint identifier.  The identifier
  length allows for 2,821,109,907,456 endpoints (36^8)
  per institution.

.LP
.MH 1 "General Considerations"

.MH 2 "Human Format"
.LP
.in 3

IBAN distinguishes between machine and human formatted endpoint
identifiers.  Machine format IBAN are simply those stripped of 
spaces (' '), dashes ('-'), periods ('.'), and any other 
non-alphanumberic characters that may occur within the IBAN
for presentation purposes.  Human format IBAN include such 
characters to aid recognition and transcription.

IIBAN implementations seeking a presentation scheme for 
similar purposes SHOULD use the [ECBS] mandated format,
consisting of the machine format IIBAN with the addition of 
a single space (' ') every four characters, ie: 'AA11 0011 123Z 5678'.

.MH 2 "Issues of Centralization"
.LP
.in 3

Conventional financial settlement systems typically assign
endpoint creation, maintenance, and identification responsibility
to large incumbent players (for example banks, major 
telecommunications carriers, online payment processors,
credit card companies, stock exchanges or brokerage firms).
In addition, financial settlement processes themselves typically
occur via a relatively small number of relatively centralized
networks.

Whilst this centralized approach is understandable from
an historic perspective, today its age and drawbacks are 
becoming more visible.

 * Systems integration and maintenance overheads due to
   disparate endpoint identification schemes, centralized
   endpoint identifier validation and differing prerequisite
   communications security configurations (for example, TLS
   client certificates [RFC5246])

 * Poor fault tolerance. Incumbent players and their
   physical, legal and communications infrastructure
   represent undesirable Single Points of Failure (SPOFs)
   that act to reduce system availability.  Classic
   examples of this are banking services that suspend
   over the weekend, and unpredictable international
   settlement delays due to differing holidays affecting
   financial services in foreign jurisdictions.

 * Potential for abuse. Attackers (or indeed individual
   nation-states or organizations within conventional
   centralized financial systems) may consider temptation
   for abuse too great to resist.  Abuses observed include
   constant, passive, warrantless surveillance of entire
   populations [SWIFT2] [EDPS], financial blockades
   [WL] [WL2] [IRAN] and asset seizure [WSJ] [BERLINGSKE].

It is hoped that IIBAN will assist the internet community
to develop systems that move beyond the above limitations.

.bp

.MH 2 "Country Code"
.LP
.in 3

In order to issue bank account numbers within the IBAN [ISO13616] scheme,
National Numbering Authority (NNA) or 'nation' status must be assumed.
An appropriate [ISO3166] two letter country code must therefore be
selected, ideally one that is not either in formal issue by the ISO or 
used informally by various global bodies.

One such code is 'AA'.  This code is considered particularly attractive
for the following reasons:

 * It is unlikely that a country will emerge that is best identified
   with 'AA'.  The ISO appears to recognize this fact, since in
   ISO 3166-1 [ISO3166] 'AA' is specified in the series of elements
   for user purposes which the ISO 3166/MA will never issue.

     "If users need code elements to represent country names not
      included in this part of ISO 3166, the series of letters AA, 
      QM to QZ, XA to XZ, and ZZ, and the series AAA to AAZ, QMA to 
      QZZ, XAA to XZZ, and ZZA to ZZZ respectively and the series of
      numbers 900 to 999 are available."
                                -- ISO 3166-1:2006, clause 8.1.3,
                                   'User-assigned code elements'.

 * 'AA' will appear above legacy, centralized financial systems in 
   alphabetically sorted destination lists

 * Users from international locations in which Roman letters are not
   frequently used are more likely to recognize 'AA' as two of the
   first letter of the Roman alphabet than arbitrary alternatives

 * The letter 'A' tends to have positive connotations

IIBAN therefore employs 'AA' as a virtual [ISO3166] two letter country
code to represent the Internet.

.LP
.MH 2 "Institution Identifiers"
.MH 3 "Issuing Paradigms"
.MH 4 "Proxied Issue Schemes"
.LP
.in 3

Conventional financial systems generally require a facilitating
institution to issue financial endpoint identifiers on behalf of 
participants; for example, banks might issue account numbers
on behalf of individuals or businesses.  Such de-facto identifier
issuing paradigms can be described as 'proxied' in that they require
participants to approach the network via one of a number of 
mediators in order to obtain a viable financial endpoint.

Drawbacks to this approach include:

 * Inefficient name space utilization.  Individual institutitons
   are unlikely to achieve complete utilization of endpoint 
   identifiers within their delegated name space.

 * Issues of centralized financial systems, described above.

The benefits of this approach are:

 * Facilitates effective name space delegation to financial 
   institutions who might apply differing models or guidelines to 
   endpoint identifier issue, therefore encouraging heterogeneity.

 * Already an operational and widely understood/accepted model
   within conventional financial service industries.

.LP
.MH 4 "Distributed Consensus Schemes"
.LP
.in 3

Using distributed consensus systems (such as distributed hash tables)
it is possible to provide dynamic identifier name space management within
a financial network itself, such that individual users might self-issue
IIBANs and have them corroborated by other network participants.

Drawbacks to this approach include:

 * The 'always on, always connected' requirement of most of these
   architectures.

 * The 'endpoint exposure' problem.
   IP addresses for critical financial systems are generally made 
   available to a DHT network, which MAY not be desirable in a
   financial services setting.

 * Name space exhaustion.
   Without some underlying capability for reliable network 
   participant identification, a single party could request vast
   quantities of identifiers in a bid to disrupt the network through
   name space exhaustion or processing overhead, causing Denial of 
   Service (DoS).

 * Latency requirements for consensus establishment.

The primary benefit of this approach is that it is completely
decentralized, thus avoiding the issues associated with centralization
(described above).

.LP
.MH 4 "Private Issue Schemes"
.LP
.in 3

Just as the Internet Protocol provides a mechanism for Address Allocation
for Private Internets [RFC1918], so too IIBAN provides a mechanism
for address allocation for private financial networks.  Private financial
networks might include those operated in Massive Multiplayer Online 
Roleplaying Games (MMORPGs), financial simulations, technical documentation
or fictional works of media.

The reserved institution code '010' is normally used for such purposes.

However, just as the latter two use cases (documentation and media) are 
segregated from the normal name space in standards for both telephony 
[NANPA, OFCOM] and IPv4 addressing [RFC5737], IIBAN also maintains a
segregated address space (under the '011' reserved institution code) for
this subset of private issue purposes.

.LP
.MH 4 "IIBAN's Combined Issue Scheme"
.LP
.in 3

The benefits and drawbacks of various issuing paradigms have already been
discussed.  IIBAN's combined issue paradigm allows the balancing of these
against other requirements, such as IANA's need to perform name space 
management.  Under this scheme, proxied issue is facilitated through IANA
managed institution registration, provision for two types of privately 
issued addresses is reserved within this document, and registered institutions
COULD provide DHT or similar mechanisms for the management of their 
delegated name space.  The combined issue paradigm offers adequate provision
for both manageability and decentralization, whilst maintaining heterogeneity.

.LP
.MH 3 "Why Institutions?"
.LP
.in 3

With the advent of decentralized virtual currencies such as [BITCOIN]
the conventional idea of a financial institution (such as a bank) may be seen
by some as somewhat superfluous.  However, the notion remains useful:

 * Conventional currencies will not disappear in the conceivable
   future, so the notion of financial institutions is expected 
   to endure at least as providers of currency exchange and holding
   services.

 * Systems such as [BITCOIN] have quirks that require slightly
   delayed settlement due to the nature of their decentralized,
   consensus-based approach to fiscal transfer.  Users requiring 
   instant settlement MAY thus see benefit in the use of a 
   centralized proxy system or organization as an instantaneous
   financial settlement provider (the 'institution').

 * IANA MAY delegate management of portions of the IIBAN name space
   through such institutions.

 * The IBAN standard mandates that each national format (BBAN)
   SHALL "include within it a bank identifier with a fixed position
   and length per country". [ISO13616]

.LP
.MH 3 "Number of Institutions"
.LP
.in 3

The current global SWIFT BIC [ISO9362] system used for international
inter-institution transaction addressing is reported to possess over
7,500 'live' codes, and an additional 10,000 codes that may be used for 
manual transactions.  We therefore assume a requirement to support at
least 15-20,000 institution identifiers within the IIBAN system.  
Significantly more than this number (1,679,616, or 36^4) has been 
provided for.

.LP
.MH 3 "Number of Endpoints per Institution"
.LP
.in 3

The number of endpoints per institution is significantly larger than is
likely to be functionally required.  However, the eight character space
allocated allows for clean and even visual grouping across functionally
disparate structural components of the IIBAN under human format visual
display requirements (ie. one space every four characters) as mandated
by the European Committee for Banking Standards [ECBS].

.LP
.MH 3 "Intra-Institution Routing"
.LP
.in 3

Intra-institution routing identifiers used in conventional financial
networks such as 'sort code' or 'branch code' have been purposefully 
excluded from IIBAN.

Institutions wishing to divide financial endpoints under their management
between disparate entities, physical or logical systems MAY create their
own address space segmentation schemes.  (It is noted that 
intra-institution routing codes are largely relics of an earlier
financial era of disconnected systems and as such will probably be 
phased out over time, at the very least as public-facing identifiers.)

.LP
.MH 2 "BBAN Length"
.LP
.in 3

BBAN lengths in the official registry [IBAN-REG] seem to be determined
solely by National Numbering Authorities (NNAs) and are allowed to
extend up to 30 characters.  In practice, however, they vary between 
about 11 and 26 characters.  To avoid issues of backwards compatibility
with existing systems, exceeding this range is undesirable.

Existing NNAs seem to determine BBAN formats simply by concatenating 
existing national account identifiers such as institution, branch and
account number.  Because these numbers are typically very old they
are often longer than strictly required as legacy identifiers:

 * Are sometimes numeric only (ie: do not include letters), or a
   significant portion of the BBAN is numeric only.

 * Often include secondary checksums that were instituted to avoid 
   financial endpoint transposition errors in the days prior to 
   electronic banking.  Such secondary checksums are no longer 
   required for non-legacy transactions due to IBAN's built-in 
   checksum feature.

Thus, by allowing alphanumeric values for each character and relying
solely upon IBAN's checksum, IIBAN increases the effective capacity of
an endpoint identifier without requiring undue increase in its length.

.bp
.LP
.MH 1 "Implementation Considerations"
.in 3

.MH 2 "Acceptance of IIBAN and IBAN"
.in 3

Implementations SHOULD accept both IIBAN and IBAN equally in all cases,
such that end users are NOT aware of any difference between the two standards.

.MH 2 "Case Sensitivity"
.in 3

Implementations MAY accept mixed or lower case IIBAN input AND normalize this input
to upper case prior to either processing or presentation.  However, because 
under the parent IBAN standard some nations' BBAN (national IBAN formats)
require a distinction between upper and lower case letters, IIBAN 
implementations MUST be careful to normalize only IIBAN (ie: NOT IBAN) to 
upper case.  Additionally, it should be noted that IIBAN's uppercase only 
format is conformant to the European Committee for Banking Standards IBAN 
implementation recommendations [ECBS].

.MH 2 "Machine vs. Human Format"
.in 3

As human format IIBANs include extraneous information, implementations
SHOULD NOT output human format IIBAN where machine format would suffice.

.MH 2 "Checksum Error Correction Suggestion"
.in 3

Implementers MAY choose to provide automatic suggestions for the resolution
of checksum errors, by flipping commonly mistranscribed characters and
revalidating the resulting IIBAN's checksum.  For example, given the 
knowledge that the characters 'O' (capital 'o') and '0' (zero) are often 
mistranscribed, when supplied the incorrect string 'AA11OO11123Z5678' as input,
an implementation COULD programatically attempt to flip these characters
and regenerate checksums, resulting in a checksum match on the 
string 'AA110011123Z5678'.  The end user would then be prompted to 
confirm this was the intended input.

When suggesting transcription error corrections, implementations SHOULD
provide additional context information where possible.  For example, if 
a suggestion alters the institution code (eg: as per the above
example) AND the implementation is either aware of the name of the 
originally input OR suggested (checksum validated) target institution,
then this information SHOULD be displayed as part of the interface that
is presented to the user for confirmation purposes.

During testing of this algorithm with a simple mistranscriptions table
(Appendix A), it was found that single-character transcription errors 
usually result in either one (ie: intended input only) or two possible
suggestions for checksum-valid IIBANs.  However, when two characters are
mistranscribed far too many suggestions were returned.  Therefore
implementations SHOULD check only for single mistransposition errors and
the extended case of multiple mistransposition errors resulting from 
miscomprehension of a single character (for example, all '0' have been
mistranscribed as 'O').

.MH 2 "Country Code Handling"
.in 3

Because IANA MAY one day wish to subsume an additional country code in
order to extend the IIBAN namespace, implementations MUST NOT implement
fixed handling of 'AA' as the sole IIBAN-reserved country code.  Instead,
implementations MUST treat the contents of IANA's IIBAN institution
identifier registry document (see IANA Considerations and Appendix B) 
as the definition of valid IIBAN prefixes.

.MH 2 "Internationalization"
.in 3

The IANA managed IIBAN Institution Identifier registry MAY include
institution names as arbitrary UTF8 strings.

To aid international recognition of individual IIBAN, only upper case 
letters are allowed within an IIBAN and IIBAN implementations MUST 
normalize all input to upper case before presentation or processing.
(See Case Sensitivity).

.MH 1 "Security Considerations"
.in 3

IIBAN only provides an endpoint identification scheme and DOES
NOT approach problems of communications security, which are 
purposefully left to other protocols.  Even so, some security 
considerations are are pertinent.

.MH 2 "Non-Linear Issue"
.in 3

To preserve the anonymity of clients and to refrain from leaking
information about the number of financial endpoints created over
a given period, institutions SHOULD refrain from issuing IIBAN in
a sequential manner.  Instead, a random or semi-random sequence 
of issue SHOULD be adopted.

.MH 2 "Validation"
.in 3

IBAN [ISO13616] and, by extension, IIBAN provide checksum digits for
algorithmic identifier validation.  Implementers MUST be aware that
the checksum is intended primarily for the early detection of 
transposition errors.  An IIBAN passing the checksum SHOULD be
referred to as 'checksum-valid'.  As it does NOT necessarily exist,
it MUST NOT be considered otherwise valid.

In addition, for the purposes of efficiency pre-checkum validation
MAY be executed.  Such validation MAY based upon one or both of the
length and structure of the IIBAN.  An IIBAN passing such validation
SHOULD be referred to as 'structure-valid'.  As it does NOT 
necessarily exist, it MUST NOT be considered otherwise valid.

The only way to completely validate an IIBAN or IBAN is with the
issuing institution.

.MH 2 "IANA Processes"
.in 3

IANA MUST provide adequate authentication of registrant institution 
communications in order to prevent the subversion of established
institutions' registration information via IANA's registrar functions.

.LP
.MH 1 "IANA Considerations"
.MH 2 "Institution Identifiers"
.MH 3 "Name Space Exhaustion"
.in 3

Should the entire 'AA' name space approach registration, IANA MUST
immediately select an additional [ISO3166] country prefix from those 
reserved by the ISO for user assignment, add it to the 'iircc' ABNF
line, and publish the new IIBAN standard with the expanded namespace.

.MH 3 "Registration"
.in 3

Institution identifiers MUST be assigned by IANA on a first come first
served basis [RFC5226].  Institution identifiers SHOULD NOT be provided
to entities capable of issuing IBAN in conventional financial networks
as this would represent duplicate allocation under the IBAN standard.
Such entities SHALL be defined as those offering banking services
in countries that appear within the IBAN registry [IBAN-REG], with
definitions of those terms being solely of IANA's own judgement.
Registrants MUST provide the domain name with which their service is 
primarily associated AND the name of the registrant (either a person 
or an organizational entity).

Institution identifiers MUST be assigned randomly from the pool of
available assignments and MUST NOT be granted on a specific request
basis.  Thus, the first issued institution code MUST NOT be '100'.
Institutions unhappy with their random assignment for legitimate
reasons (such as unfortunate linguistic connotations) MAY request 
one (1) replacement assignment.  No further replacement is allowed.
Registrants requesting replacement assignments automatically cause
their initial allocation to expire (see Expiry, below).

.MH 3 "Modification / Cancellation"
.in 3

Registrants MUST contact IANA to cancel or change the details 
associated with their registration.  Authentication procedures will
be stipulated at IANA's discression.

.MH 3 "Expiry"
.in 3

In case of imminent name space exhaustion and no viable alternative
avenues for expansion, IANA MAY consider the expiry of a 
registrant's stated primary domain for a reasonable period (as 
determined by IANA) as adequate grounds for the deallocation of
an instutition identifier.  Deallocated identifiers MUST be 
immediately returned to the pool of available allocations, and
MUST be re-issued to new parties on a first come, first served 
[RFC5226] basis.

.MH 2 "Publications"

.MH 3 "IIBAN Institution Identifier Registry"
.in 3

IANA SHALL publish revisions to the global registry of IIBAN 
institution identifiers as changes are made.

IANA SHALL provide GPG-compatible cryptographic signatures along with 
each version of the registry.  IANA MAY provide additional 
cryptographic signatures and/or checksums, at their discretion.

The registry SHALL utilize UTF8 encoding in order to meet
internationalization requirements for institution names.

The format and initial contents of this registry document are specified
in Appendix B.

.MH 2 "ISO Liason"
.in 3

On account of IIBAN's exclusive use of IBAN's reserved, user assigned 
name space, ISO liason IS NOT required.

.MH 2 "Security"
.in 3

IANA MUST provide adequate authentication of registrant institution
communications in order to prevent the subversion of established
institutions' registration information via IANA's registrar functions.
As IANA is likely to have superior experience in this domain, specific
procedures are left to IANA's judgement.

.bp
.LP
.MH 1 "References"
.MH 2 "Normative References"
.LP
.in 3

[ECBS]          European Committee for Banking Standards
                "IBAN: Standard Impementation Guidelines",
                SIG203 v3.2, August 2003.
                http://www.europeanpaymentscouncil.eu/
                 knowledge_bank_download.cfm?
                 file=ECBS%20standard%20implementation%20guidelines%20SIG203V3.2.pdf
                
[ISO9362]       ISO TC 68/SC 7 (Core Banking), "ISO 9362:2009:
                Banking - Banking telecommunication messages -
                Business identifier code (BIC)", ISO 9362:2009.
                http://www.iso.org/iso/catalogue_detail?
                 csnumber=52017

[ISO13616]      ISO TC 68/SC 7 (Core Banking), "ISO 13616-1:2007: 
                Financial services - International bank account 
                number (IBAN) -- Part 1: Structure of the IBAN",
                ISO 13616-1:2007.
                http://www.iso.org/iso/catalogue_detail?
                 csnumber=41031

[ISO7064]       ISO JTC 1/SC 27 (IT Security techniques), 
                "ISO/IEC 7064:2003: Information technology -
                Security techniques - Check character systems",
                ISO/IEC 7064:2003.
                http://www.iso.org/iso/iso_catalogue/
                 catalogue_tc/catalogue_detail.htm?csnumber=31531

[IBAN-REG]      SWIFT, "ISO13616 IBAN Registry", 
                http://www.swift.com/solutions/messaging/
                 information_products/directory_products/
                 iban_format_registry

[RFC2119]       Bradner, S., "Key words for use in RFCs to
                Indicate Requirement Levels", BCP 14, RFC 2119,
                March 1997.  

[RFC5226]       Narten, T., and H. Alvestrand, "Guidelines for
                Writing an IANA Considerations Section in RFCs",
                BCP 26, RFC 5226, May 2008.

[RFC5234]       Crocker, D. and P. Overell, "Augmented BNF for
                Syntax Specifications: ABNF", STD 68, RFC 5234,
                January 2008.

.fi

.bp

.LP
.MH 2 "Informative References"
.LP
.in 3

[BERLINGSKE]    Simon Bendtsen & Peter Suppli Benson,
                "Dansk politimand fanget i amerikansk terrornet",
                Berlingske, 26 February 2012.
                http://www.b.dk/nationalt/
                 dansk-politimand-fanget-i-amerikansk-terrornet

[BITCOIN]       Nakamoto, S., "Bitcoin: A Peer-to-Peer Electronic
                Cash System", 2009-05-24.
                http://www.bitcoin.org/bitcoin.pdf

[EDPS]          European Data Protection Supervisor,
                "Comments on the Communication from the Commission to
                the European Parliament, the Council, the European
                Economic and Social Committee and the Committee of
                the Regions of 13 July 2011: 'A European terrorist
                finance tracking system: Available options'",
                25 October, 2011.  (Relevant excerpt follows:
                 "Currently, under TFTP, data are sent in bulk to
                  the US, to be stored and filtered according to 
                  requests of the US Treasury Department. This has
                  raised serious criticism, especially by the 
                  European Parliament (and obviously the EDPS and
                  WP29), notably with regard to the necessity and
                  proportionality of the 'bulk' data flows")
                http://www.edps.europa.eu/EDPSWEB/webdav/site/mySite/
                 shared/Documents/Consultation/Comments/2011/
                 11-10-25_Comments_TFTS_EN.pdf
                  
[ISO3166]       ISO 3166/MA, "ISO - Maintenance Agency for ISO 
                3166 country codes" and "ISO 3166-1 decoding table",
                November 2011.
                http://www.iso.org/iso/country_codes.htm

[NANPA]         NANPA, "555 Report", November 2011.
                http://www.nanpa.com/nas/public/
                 form555MasterReport.do?method=display555MasterReport

[OFCOM]         OFCOM, "Telephone Numbers for drama use (TV, Radio
                etc)", November 2011.
                http://stakeholders.ofcom.org.uk/telecoms/numbering/
                 guidance-tele-no/numbers-for-drama

[PHPIBAN]       Stanish, Walter. The PHP IBAN project.
                http://code.google.com/p/php-iban/

[RFC1918]       Rekhter, Y. et al, "Address Allocation for Private
                Internets", BCP 5, RFC 1918, Feburary 1996.

[RFC5246]       Dierks, T., and E. Rescorla, "The Transport Layer
                Security (TLS) Protocol - Version 1.2", RFC5246,
                August 2008.

[RFC5737]       Arkko, Cotton and Vogoda, "IPv4 Address Blocks
                Reserved for Documentation", RFC5737, January 2010.

[SWIFT2]        European Parliament, "Parliament gives green light
                for SWIFT II", #20100707IPR78054, 8th July, 2010.
                http://www.europarl.europa.eu/sides/getDoc.do?
                 language=en&type=IM-PRESS&reference=20100707IPR78054

[WL]            Wikileaks, "Banking Blockade", October 2011.
                http://wikileaks.org/Banking-Blockade.html

[WL2]           The Nonprofit Quarterly, "The Financial Blockade of
                WikiLeaks and Its Meaning for the Nonprofit Sector",
                October 2011.
                http://www.nonprofitquarterly.org/?option=com_content
                 &view=article&id=17171

[WSJ]           Emshwiller, J., and G. Fields, "Federal Asset Seizure
                Seizures Rise, Netting Innocent With Guilty", The 
                Wall Street Journal, August 2011.
                http://online.wsj.com/article/
                 SB10001424053111903480904576512253265073870.html
.fi

.LP
.MH 1 "Acknowledgments"
.LP
.in 3

 * Payward, Inc. funded the research and development of this document.

.MH 1 "Authors' Addresses"
.LP
.in 3

Prepared by Walter Stanish <walter@stani.sh> of Payward, Inc. on 
behalf of The Internet Financial EXchange (IFEX) Project: 
http://www.ifex-project.org/

.bp

.MH 1 "Appendix A: Mistranscription Table"
.LP
.in 3
The ABNF [RFC5234] grammar below identifies alternate Roman letters and
numerals from which a user-input character may reasonably be supposed to
have originated.  Information was compiled manually, taking in to account
various writing styles and perceived common errors of recognition across
both the lower and upper case letter forms.  Note that the data is not 
based upon formal research and is is reproduced here for the sole 
purpose of providing a reasonable and convenient basis for IIBAN-based
system implementation.  Replacement characters have been roughly 
ordered by estimate mistransposition frequency.  A reference implementation
is available [PHPIBAN].

(Note: Such a structure may apparently be known as a 'confusion
matrix' in the field of artificial intelligence, or a 'contingency table' or
\'error matrix' in other fields of computing.  Instead, we use the term
\'mistranscription table' as it seems less generic and more self-evident.)

.PP
.in 0
 ; formalities
 roman-char = number / letter
 number     = c-0 / c-1 / c-2 / c-3 / c-4 / c-5 / c-6 / c-7 / c-8 / c-9
 letter     = c-a / c-b / c-c / c-d / c-e / c-f / c-g / c-h / c-i / c-j
                  / c-k / c-l / c-m / c-n / c-o / c-p / c-q / c-r / c-s
                  / c-t / c-u / c-v / c-w / c-x / c-y / c-z

 ; possible sources of mistranscribed numbers
 c-0 = "O" / "6" / "D" / "G"
 c-1 = "I" / "L" / "7" / "2" / "Z"
 c-2 = "Z" / "7" / "P" / "E" / "1"
 c-3 = "8" / "B"
 c-4 = "G" / "U"
 c-5 = "S" / "7"
 c-6 = "0" / "O" / "8" / "G" / "C" / "B" / "D"
 c-7 = "J" / "I" / "1" / "L"
 c-8 = "B" / "3" / "6"
 c-9 = "G" / "Y" / "O" / "0" / "D"

 ; possible sources of mistranscribed letters
 c-a = "G" / "Q" / "O" / "0"
 c-b = "6" / "3" / "8" / "P" / "0" / "O"
 c-c = "R" / "6" / "I" / "L" / "O" / "0"
 c-d = "0" / "O" / "9" / "Q" / "G" / "6" / "A"
 c-e = "F" / "G" / "0" / "2" / "K" / "Z" / "S" / "O"
 c-f = "E" / "K" / "T" / "P" / "Y" / "4" / "B" / "7" / "1"
 c-g = "9" / "Q" / "8" / "6" / "0" / "C" / "4" / "O"
 c-h = "B" / "N" / "A" / "4" / "6" / "M" / "W" / "F" / "R" / "T" / "X"
 c-i = "1" / "L" / "7" / "J" / "2" / "T" / "Z"
 c-j = "I" / "7" / "2" / "9" / "1" / "U" / "T" / "Q" / "P" / "Y" / "Z"
           / "L" / "S"
 c-k = "F" / "X" / "H" / "R" 
 c-l = "1" / "2" / "7" / "C" / "I" / "J" / "R" / "T" / "Y" / "Z"
 c-m = "H" / "8" / "E" / "3" / "N" / "V" / "W" 
 c-n = "H" / "R" / "C" / "2" / "4" / "M" / "O" / "P" / "K" / "T" / "Z"
 c-o = "0" / "6" / "9" / "A" / "D" / "G" / "C" / "E" / "B" / "N" / "P"
           / "Q" / "R"
 c-p = "F" / "4" / "8" / "2" / "B" / "J" / "R" / "N" / "O" / "T" / "Y"
 c-q = "O" / "G" / "9" / "Y" / "1" / "7" / "L"
 c-r = "K" / "B" / "V" / "C" / "1" / "L" / "2"
 c-s = "5" / "6" / "9" / "B" / "G" / "Q" / "A" / "Y"
 c-t = "1" / "4" / "7" / "F" / "I" / "J" / "L" / "P" / "X" / "Y"
 c-u = "V" / "N" / "A" / "4" / "9" / "W" / "Y"
 c-v = "U" / "R" / "N"
 c-w = "M" / "N" / "U" / "V"
 c-x = "K" / "F" / "4" / "T" / "V" / "Y"
 c-y = "G" / "V" / "J" / "I" / "4" / "9" / "T" / "F" / "Q" / "1"
 c-z = "2" / "1" / "L" / "R" / "I" / "7" / "V" / "3" / "4"

.bp

.MH 1 "Appendix B: Initial IIBAN Institution Identifier Registry Contents"

Prior to IANA handover, parties wishing to acquire an instutition 
identifier may do so by contacting the IFEX Project via ifex-project.org

.PP
.in 0
 # IIBAN Institution Identifier Registry.
 #
 # To be cryptographically signed by IANA and replicated freely.
 #
 # Format:
 #  - Lines beginning with '#' are comments.
 #  - Whitespace should be ignored.
 #  - Fields at the end of a record may be absent.
 #  - Records are comprised of the following fields (ABNF):
 #     country-code institution-code "|" created "|" modififed \\
 #       "|" domain "|" registrant "|" fingerprint
 #
 # Fields:
 #  country-code      Two letter ISO 3166-1 alpha-2 country code.
 #  institution-code  Three character institution identifier.
 #  created           Date of registration (YYYY-MM-DD).
 #  modified          Date last modified (YYYY-MM-DD), or blank.
 #  domain            Primary domain name associated with the record.
 #  registrant        Native language name of the registrant (UTF8).
 #  fingerprint       Optional public key fingerprint.  Format is
 #                    the concatenated (whitespace stripped) output
 #                    of a GPG fingerprint, obtainable via 
 #                    `gpg -k; gpg --fingerprint <keyid>`.
 AA0010|2012-11-13|||(IANA: Reserved for private use)
 AA0011|2012-11-13|||(IANA: Reserved for documentation/public fiction)
 AA34CF|2012-11-13||payward.com|Payward|29ABE6723D760F83A27E77D563635213C8515C12

.bp

.MH 1 "Appendix C: Document History"

draft-stanish-iiban-00 (2012-11-13)
  - Update recommended human format to ECBS.
  - Update ABNF specification to respect case.
  - Document modifications (including document name) as requested for
    conformance with BCP 78 and BCP 79.
  - Add European Committee for Banking Standards (ECBS) recommendations
    conformity notes, including modification to document abstract.
  - Remove requirement for the support of lowercase input, in line with
    ECBS recommendations.
  - Extend institution code length from three to four characters, and
    account code length from six to eight characters, in line with the
    ECBS-mandated presentation for human format IBAN.
  - Mandate IANA registry signature in GPG format.
  - Added explanatory note on mistranscription terminology.
  - Added Danish report on US seizure of an intra-European transfer.
  - Added European Data Protection Supervisor comments.
  - Corrected reserved institution code table summary.
  - Typographic error correction.
  - Various minor changes in nomenclature.

draft-iiban-01 (2012-04-13)
  - Added request to accept IBAN and IIBAN equally.
  - Added case sensitivity information.
  - Developed and added a reference mistranscriptions table and 
    the resulting 'Checksum Error Correction Suggestion' section.
  - Added official limitation of 30 characters per BBAN.
  - Added IBAN's fixed length national institution identifier
    requirement.
  - Generalized DHT scheme description to distributed consensus systems.
  - Added latency as a drawback to distributed consensus systems.
  - Rewording of some sections, notably IANA Considerations.
  - Typographic error correction.
  - Added 'iircc' field to ABNF and 'Country Code Handling' to 
    implementation section in order to discourage hard coded
    country portions in early implementations.
  - Added 'Human Format' section due to observed implementation issues.
  - Added 'Machine vs. Human Format' section.
  - Added 'Internationalization' section.
  - Removed extraneous registration information that likely duplicates
    data already available through DNS (business address, etc.)
  - Added initial registry contents and format definition.

draft-iiban-00 (2011-11-16)
  Initial relase.
.DE
.COPYFULL

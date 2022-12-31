---
title: TikiSdkConsent
excerpt: A Consent Object. Representative of the NFT created on-chain. Requires a corresponding Data Ownership NFT (see [TikiSdk](tiki-sdk-ios-tiki-sdk)).
category: 6392ca22e73ff0002e0a9952
slug: tiki-sdk-ios-tiki-sdk-consent
hidden: false
order: 5
---

## Properties

##### ownershipId &#8596; String
The data ownership transaction ID corresponding to the data source consent applies to.  
_read / write_

##### destination &#8596; [TikiSdkDestination](tiki-sdk-ios-tiki-sdk-destination)
The destination describing the allowed/disallowed paths and use cases for the consent.  
_read / write_

##### reward &#8596; String?
An optional description of the reward owed to user in exchange for consent.
_read / write_

##### about &#8596; String?
An optional description to provide additional context to the transaction. Most typically as human-readable text.  
_read / write_

##### transactionId &#8596; String
The transaction id for `this`  
_read / write_

##### expiry &#8596; Int?
The date (milliseconds since epoch) the consent is valid until. Do not set (`nil`) for perpetual consent.
_read / write_

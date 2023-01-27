---
title: TikiSdkOwnership
excerpt: A Ownership Object. Representative of the NFT created on-chain. 
category: 6392ca22e73ff0002e0a9952 
slug: tiki-sdk-ios-tiki-sdk-ownership 
hidden: false 
order: 4
---

## Properties

##### source &#8596; String

An identifier in your system corresponding to the raw data.
_i.e. a user_id_
_read / write_

##### type &#8596; [TikiSdkDataTypeEnum](tiki-sdk-ios-tiki-sdk-data-type-enum)

`data_point`, `data_pool`, or `data_stream`  
_read / write_

##### origin &#8596; String

The origin from which the data was generated.
_read / write_

##### transactionId &#8596; String

The transaction id for `this` 
_read / write_

##### contains &#8596; [String]

A list of metadata tags describing the represented data.
_read / write_

##### about &#8596; String

An optional description to provide additional context to the transaction, typically as human-readable text.
_read / write_
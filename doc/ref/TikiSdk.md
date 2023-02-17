---
title: TikiSdk
excerpt: The primary object for interacting with the TIKI infrastructure. Use `TikiSdk` to assign ownership, modify, and apply consent.
category: 6392ca22e73ff0002e0a9952
slug: tiki-sdk-ios-tiki-sdk
hidden: false
order: 1
---

## Constructors

##### TikiSdk (...)

**async function**  
_must be called from async function or [Task](https://developer.apple.com/documentation/swift/task)_

Named Parameters:

- **publishingId &#8594; String**
  A unique identifier for your account. Create, revoke, and cycle Ids (not a secret but try and treat it with care) at [console.mytiki.com](https://console.mytiki.com).


- **origin &#8594; String**  
  Included in the on-chain transaction to denote the application of origination (can be overridden in individual requests). It should follow a reversed FQDN syntax. i.e. com.mycompany.myproduct


- **address &#8594; String? = nil**  
  Set the user address (primarily for restoring the state on launch). If not set, a new key pair and address will be generated for the user.

Example:

```
val tiki = try await TikiSdk().init(publishingId: "YOUR_API_ID", origin: "com.mycompany.myproduct")
```

## Methods

##### assignOwnership(...) &#8594; String
Data ownership can be assigned to any data point, pool, or stream, creating an immutable, on-chain record.  

**async function**  
_must be called from async function or [Task](https://developer.apple.com/documentation/swift/task)_

Named Parameters:
- **source &#8594; String**  
  An identifier in your system corresponding to the raw data.  
  _i.e. a user_id_


- **type &#8594; [TikiSdkDataTypeEnum](tiki-sdk-ios-tiki-sdk-data-type-enum)**  
  One of `"data_point"`, `"data_pool"`, or `"data_stream"`


- **contains &#8594; Array&lt;String>**  
  A list of metadata tags describing the represented data


- **origin &#8594; String? = nil**  
  An optional override of the default origin set during initialization


- **about &#8594; String? = nil**  
  An optional description to provide additional context to the transaction. Most typically as
  human-readable text.

Returns:

- **String**  
  The unique transaction id (use to recall the transaction record at any time)

Example:

```
let oid = try await tiki.assignOwnership(source: "12345", type: TikiSdkDataTypeEnum.point, contains: ["email_address"])
```

&nbsp;

##### modifyConsent(...) &#8594; [TikiSdkConsent](tiki-sdk-ios-tiki-sdk-consent)
Consent is given (or revoked) for data ownership records. Consent defines "who" the data owner has given utilization rights.

**async function**  
_must be called from async function or [Task](https://developer.apple.com/documentation/swift/task)_

Named Parameters:
- **ownershipId &#8594; String**  
The transaction id for the ownership grant


- **destination &#8594; [TikiSdkDestination](tiki-sdk-ios-tiki-sdk-destination)**  
A collection of paths and application use cases that consent has been granted (or revoked) for.


- **about &#8594; String? = nil**  
An optional description to provide additional context to the transaction. Most typically as human-readable text.


- **reward &#8594; String? = nil**  
An optional definition of a reward promised to the user in exchange for consent.


- **expiry &#8594; Date ? = nil**  
  The date upon which the consent is no longer valid. If not set, consent is perpetual.

Returns:

- **[TikiSdkConsent](tiki-sdk-ios-tiki-sdk-consent)**  
  the modified `TikiSdkConsent`

Example:
```
let consent = try await tiki.modifyConsent(ownershipId: oid, destination: TikiSdkDestination.all())
```

&nbsp;

##### getOwnership(source: String, origin: String? = nil) &#8594; [TikiSdkOwnership](tiki-sdk-ios-tiki-sdk-ownership)?

Get the `TikiSdkOwnership` for a `source` and `origin`. If `origin` is unset, the default set during construction is used.

**suspend function**  
_must be called from within a coroutine_

Named Parameters:

- **source &#8594; String**  
  An identifier in your system corresponding to the raw data.  
  _i.e. a user_id_

- **origin &#8594; String? = nil**  
  An optional override of the default origin set during initialization

Returns:

- **[TikiSdkOwnership](tiki-sdk-ios-tiki-sdk-ownership)?**  
  the assigned `TikiSdkOwnership`

Example:

```
val ownership = try await tiki.getOwnership(source: "12345")
```

&nbsp;

##### getConsent(source: String, origin: String? = nil)  &#8594; [TikiSdkConsent](tiki-sdk-ios-tiki-sdk-consent)?
Get the latest `TikiSdkConsent` for a `source` and `origin`. If `origin` is unset, the default set during construction is used.

**async function**  
_must be called from async function or [Task](https://developer.apple.com/documentation/swift/task)_


Named Parameters:
- **source &#8594; String**  
  An identifier in your system corresponding to the raw data.  
  _i.e. a user_id_


- **origin &#8594; String? = nil**  
An optional override of the default origin set during initialization


Returns:

- **[TikiSdkConsent](tiki-sdk-ios-tiki-sdk-consent)**  
  the modified `TikiSdkConsent`

Example:
```
let consent = try await tiki.getConsent(source: "12345")
```

&nbsp;

##### applyConsent(...) 
Apply consent to a data transaction. If consent is granted for the `source` and `destination` and has not expired, the request is executed.

**async function**  
_must be called from async function or [Task](https://developer.apple.com/documentation/swift/task)_


Named Parameters:
- **source &#8594; String**  
An identifier in your system corresponding to the raw data.  
_i.e. a user_id_


- **destination &#8594; [TikiSdkDestination](tiki-sdk-ios-tiki-sdk-destination)**  
The destination(s) and use case(s) for the request.


- **request &#8594; (() &#8594; Void)**  
The function to execute if consent granted


- **onBlocked &#8594; ((String) &#8594; Void)? = nil**  
The function to execute if consent is denied.


- **origin &#8594; String? = nil**  
  An optional override of the default origin set during initialization

Example:
```
try await applyConsent(source: "12345", destination: TikiSdkDestination.all(), request: {
  print("Consent Approved. Send data to backend.")
});
```

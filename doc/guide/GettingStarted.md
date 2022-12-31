---
title: Getting Started
excerpt: See just how easy (and fast) it is to add TIKI to your iOS app —drop in a data exchange to increase user opt-ins and lower risk.
category: 6392d60b0bf6850082188e5c
slug: tiki-sdk-ios-getting-started
hidden: false
order: 1
next:
  pages:
    - type: ref
      icon: book
      name: View the entire API
      slug: tiki-sdk-ios-tiki-sdk
      category: SDK [iOS]
---

### Installation

Add the Swift Package repository. If you're unfamiliar, checkout Apple's [instructions](https://developer.apple.com/documentation/xcode/adding-package-dependencies-to-your-app).

```
https://github.com/tiki/tiki-sdk-ios
```


### Usage

#### 1. [Sign up](https://console.mytiki.com) (free) for a TIKI developer account to get an API ID.

#### 2. Initialize the [TIKI SDK](tiki-sdk-ios-tiki-sdk)

_Note: async —must be called from an async function or [Task](https://developer.apple.com/documentation/swift/task)_

Configuration parameters:

- **apiId &#8594; String**   
  A unique identifier for your account. Create, revoke, and cycle Ids _(not a secret but try and treat it with care)_ at https://mytiki.com.


- **origin &#8594; String**  
  Included in the on-chain transaction to denote the application of origination (can be overridden in individual requests). It should follow a reversed FQDN syntax. _i.e. com.mycompany.myproduct_


- **address &#8594; String? = nil**  
  Set the user address (primarily for restoring the state on launch). If not set, a new key pair and address will be generated for the user.


Example:

```
Task {
  let tiki = try await TikiSdk(apiId: "565b3268-cdc0-4e5c-94c8-5d8f53d4577c", origin: "com.mycompany.myproduct")
}
```

#### 3. Assign ownership
Data ownership can be assigned to any data point, pool, or stream, creating an immutable, on-chain record.

Named Parameters:
- **source &#8594; String**  
  An identifier in your system corresponding to the raw data. _i.e. a user_id_


- **type &#8594; [TikiSdkDataTypeEnum](tiki-sdk-ios-tiki-sdk-data-type-enum)**  
  `"data_point"`, `"data_pool"`, or `"data_stream"`


- **contains &#8594; Array&lt;String>**  
  A list of metadata tags describing the represented data


- **about &#8594; String? = nil**  
  An optional description to provide additional context to the transaction. Most typically as human-readable text.


- **origin &#8594; String? = nil**  
  An optional override of the default origin set during initialization

Returns:

- **String**  
  The unique transaction id (use to recall the transaction record at any time)


Example:

```
Task {
  ...
  let oid = try await tiki.assignOwnership(source: "12345", type: TikiSdkDataTypeEnum.point, contains: ["email_address"])
}
```

#### 4. Modify consent
Consent is given (or revoked) for data ownership records. Consent defines "who" the data owner has given utilization rights.

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
Task {
  ...
  let consent = try await tiki.modifyConsent(ownershipId: oid, destination: TikiSdkDestination(["*"], ["*"]));
}
```

#### 5. Apply consent
Apply consent to a data transaction. If consent is granted for the `source` and `destination` and has not expired, the request is executed.

Parameters:
- **source &#8594; String**  
An identifier in your system corresponding to the raw data.  
_i.e. a user_id_


- **destination &#8594; [TikiSdkDestination](tiki-sdk-ios-tiki-sdk-destination)**  
The destination(s) and use case(s) for the request.


- **request &#8594; ((String?) &#8594; Void)**  
The function to execute if consent granted


- **onBlocked &#8594; ((String?) &#8594; Void)**  
The function to execute if consent is denied.


- **origin &#8594; String? = null**  
  An optional override of the default origin set during initialization


Example:
```
Task {
  ...
  try await applyConsent(source: "12345", destination: TikiSdkDestination(["*"], ["*"]), request: {
    print("Consent Approved. Send data to backend.")
  });
}
```

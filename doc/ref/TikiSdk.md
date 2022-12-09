---
title: TikiSdk
excerpt: The primary object for interacting with the TIKI infrastructure. Use `TikiSdk` to assign ownership, modify, and apply consent.
category: 6392ca22e73ff0002e0a9952
slug: tiki-sdk-ios-tiki-sdk
hidden: false
order: 1
---

## Constructors

##### TikiSdk (apiId: String, origin: String, onBuild: ((success: Bool, response: String?) &#8594; Void)? = nil)

## Methods

##### assignOwnership(source: String, type: String, completion: ((success: Bool, response: String?) &#8594; Void)? = nil, contains: Array&lt;String>? = nil, about: String? = nil, origin: String? = nil)
Data ownership can be assigned to any data point, pool, or stream, creating an immutable, on-chain record.  

Parameters:
- **source &#8594; String**  
An identifier in your system corresponding to the raw data.  
_i.e. a user_id_


- **type &#8594; String**  
One of `"point"`, `"pool"`, or `"stream"`


- **completion &#8594; ((success: Bool, response: String?) &#8594; Void)?**
A callback function to execute on completion. Input (**String**) is the unique transaction id (use to recall the transaction record at any time)


- **contains &#8594; Array&lt;String>**  
A list of metadata tags describing the represented data


- **origin &#8594; String?**  
An optional override of the default origin set during initialization


- **about &#8594; String?**  
An optional description to provide additional context to the transaction. Most typically as human-readable text.

Example:

```
let completion = { (success: Bool, response: String) -> print(response) };
tiki.assignOwnership("12345", "point", completion, ["email_address"]);
```

&nbsp;

##### modifyConsent(ownershipId: String, destination: [TikiSdkDestination](tiki-sdk-ios-tiki-sdk-destination), callback: completion: ((success: Bool, response: String?) &#8594; Void)? = nil, about: String? = nil, reward: String? = nil) 
Consent is given (or revoked) for data ownership records. Consent defines "who" the data owner has given utilization rights.

Parameters:
- **ownershipId &#8594; String**  
The transaction id for the ownership grant


- **destination &#8594; [TikiSdkDestination](tiki-sdk-ios-tiki-sdk-destination)**  
A collection of paths and application use cases that consent has been granted (or revoked) for.


- **completion &#8594; ((success: Bool, response: String?) &#8594; Void)?**
A callback function executed on completion. Input (**String**) is the modified consent.


- **about &#8594; String?**  
An optional description to provide additional context to the transaction. Most typically as human-readable text.


- **reward &#8594; String?**  
An optional definition of a reward promised to the user in exchange for consent.


Example:
```
let completion = { (success: Bool, response: String) -> print(response) };
tiki.modifyConsent(oid, TikiSdkDestination(["*"], ["*"]), completion);
```

&nbsp;

##### getConsent(source: String, completion: ((success: Bool, response: String?) &#8594; Void)? = nil, origin: String? = nil)  
Get the latest `TikiSdkConsent` for a `source` and `origin`. If `origin` is unset, the default set during construction is used.

Parameters:
- **source &#8594; String**  
  An identifier in your system corresponding to the raw data.  
  _i.e. a user_id_


- **completion &#8594; ((success: Bool, response: String?) &#8594; Void)?**
  A callback function executed on completion. Input (**String**) is the returned consent.


- **origin &#8594; String?**  
An optional override of the default origin set during initialization

Example:
```
let completion = { (success: Bool, response: String) -> print(response) };
tiki.getConsent("12345", completion);
```

&nbsp;

##### applyConsent(source: String, destination: [TikiSdkDestination](tiki-sdk-ios-tiki-sdk-destination), request: (String?) &#8594; Void, onBlocked: (String?) &#8594; Void) 
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


Example:
```
applyConsent("12345", TikiSdkDestination(["*"], ["*"]),
             {(_) -> print("Consent Approved. Send data to backend.")},
             {(_) -> print("Consent Denied.")});
```

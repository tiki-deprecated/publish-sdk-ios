---
title: TikiSdkDestination
excerpt: Defines destinations and use cases (optional) allowed or disallowed. Serializable for inclusion in transactions.
category: 6392ca22e73ff0002e0a9952
slug: tiki-sdk-ios-tiki-sdk-destination
hidden: false
order: 3
---

## Constructors

##### TikiSdkDestination(uses: Array&lt;String>, paths: Array&lt;String>)
Creates a new destination from a list of `paths` and `uses`.

## Static Methods

##### all() : TikiSdkDestination
Builds a TikiSdkDestination for all destinations and use cases

##### none() : TikiSdkDestination
Builds a TikiSdkDestination for no destinations or use cases

##### fromJson(jsonString: String) : TikiSdkDestination
Builds a TikiSdkDestination from a JSON string

## Properties

##### uses &#8594; Array&lt;String>
A list of application specific uses cases applicable to the given destination. Prefix with NOT to invert.  
_i.e. NOT ads_  

##### paths &#8594; Array&lt;String>
A list of paths, preferably URLs (without the scheme) or reverse FQDN. 
Keep list short and use wildcard matching. Prefix with NOT to invert.  
_i.e. NOT mytiki.com/.

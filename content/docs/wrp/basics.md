---
title: Basics
sort_rank: 2
---

# Basics

WRP messages are designed to be uniform and for a particular purpose.  Some
are designed so they can be routed globally, while others are designed to
prevent any routing.

## Overarching Guidelines

- All strings in WRP are UTF-8.
- The `payload` can not be altered.
- Extra key/value pairs are ignored so log as they do not conflict with the spec.

## Locators

In many of the WRP message types there are `source` and `dest` string fields.
These fields are locators used for routing purposes.  There are three basic types:
- Device Identifiers - locators that uniquely identify a device
- Event Locators - locators that denote the event destination or topic
- Service Locators - locators that are used by services

The general scheme used by the locators is: `{scheme}:{authority}/{service}/{ignored}`

- `scheme` is one of: [ `mac`, `serial`, `uuid`, `event`, `dns` ] and describes
  how to process the rest of the locator.
- `authority` is scheme specific, but provides the identification of the type
  required by the `scheme`.
- `service` is the service or process or endpoint where a particular message should
  be routed on a device, or originates from.
- `ignored` is the portion of the locator that is explicitly ignored by the
  routing layers.

Cloud based routing focuses on the combination of `{scheme}:{authority}` ignoring
the rest.  On device routing focues on the `{service}` portion and ignores the
rest.  This provides applications the entire `{ignored}` namespace for use.

### Device Identification

Each connection is generally presumed to be from a consumer premise device of
some sort.  Examples are devices like internet router gateways, a thermostat or
similar.  In order to be able to find and communicate with the edge device a
device must have an identifier of some sort.  The identifier is defined as the
`device_id`.  Each connection/device may have **exactly one** identifier.

Services that use the routing must also be able to enumerate themselves.

The `device_id` is a case insensitive UTF-8 string locator defined with the
following scheme:

- `mac:{mac address}/{service}/{ignored}` - generally used for a CPE device
- `serial:{serial number}/{service}/{ignored}` - generally used for a CPE device
- `uuid:{the uuid}/{service}/{ignored}` - not widely used, but could be used to
  represent an account/device tuple.

The `device_id` is not resolved or verified except for routing purposes once the
connection has been established.


### Event Locators

The event locator is a simplified locator that only contains the scheme and
authority portions.  The rest of the locator is ignored (except for matching
which is covered in Caduceus).

- `event:{event identifier}/{ignored}`

### Service Locators

Service locators are designed to provide identification based on a DNS name.
It is up to the calling application to determine if a unique host name or a
shared host name is best.  Both are supported.

- `dns:{host name}/{service}/{ignored}`

---
title: Basics
sort_rank: 20
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

### QOS Description (qos):

The `qos` field describes the overall quality of service to apply to the message
as well as the relative priority of the message when compared to others.  If there
are resource shortages (generally encountered during loss of network connectivity
or large floods of messages) if messages must be dropped, the priority is used
to determine which are kept and which are dropped.

Additionally, for **Simple Event Definition** messages the ability to receive
an ack indicating that the message has made it to the cloud & is now the
responsibility of the cloud to handle is available.  Note that this is the only
message type that may receive the new ack message.

Values | Priority | Description
-------|----------|-------------
`[0-24]` | **Low** | These messages are sent as fire and forget with "best effort" or "at most once" semantics.
`[25-49]` | **Medium** | These messages are enqueued in the client/agent until their delivery to the cloud has been confirmed.  Cloud will ack with a `qos_ack` message to the agent.
`[50-74]` | **High** | Same behavior as **Medium** plus the agent will propagate response ack to original requester if the message is a **Simple Event Definition** type.
`[75-99]` | **Critical** | Same behavior as **High** plus the cloud will take any additional means available to ensure delivery.

### Request Delivery Response (rdr) Codes:

  0 `0` - **Delivered**
  * `1-99` - **Invalid WPR**
    * `1` - Message format is invalid
    * `2` - Missing source
    * `3` - Missing dest
    * `4` - Message is too large
    * `5-49` - Reserved for future use by the spec
    * `50-99` - Reserved for specific implementation definition and use
  * `100-199` - **Fulfillment Issue**
    * `100` - Unable to enqueue
    * `101` - Agent was disconnected for too long
    * `102` - A higher priority message took the spot
    * `103-149` - Reserved for future use by the spec
    * `150-199` - Reserved for specific implementation definition and use
  * All other values are reserved by the spec for future use

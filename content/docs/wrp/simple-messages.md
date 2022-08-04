---
title: Simple Message Types
sort_rank: 30
---

# Simple Message Types

All messages are msgpack encoded and contain a `msg_type` field.  Beyond that
field, the contents depend on the use case.

To make the document easier to read, the msgpack is written out in a bit more
human readable format.

One design goal for the message definition is to make sure it can be translated
to and from JSON and HTTP headers as well as it's native msgpack format.

## Simple Request-Response Definition

This is one of the primary message definitions used.  This provides a point to
point (request, response) semantic.  An example of where this message is used is
between Webpa's `Tr1d1um` machine and the `Parodus2ccsp` client that interprets
the request, gathers data and responds back.  Both requests and responses use
the same message type.

#### Schema
~~~~~
{
    Integer msg_type = 3
    String source
    String dest
    String content_type
    String accept
    String transaction_uuid
    Integer status
    Integer rdr
    Array.String partner_ids
    Array.String headers
    Map[String] metadata
    Array.Array spans
    String span_parent
    Boolean include_spans
    Integer qos
    Binary payload

}
~~~~~

Name | Description
-----|--------------
msg_type | The message type for the request-response.  (**SHALL** be 3.)
source | The device_id name of the device originating the request or response.
dest | The device_id name of the target device of the request or response.
content_type | (optional) The media type of the payload.
accept | (optional) The media type accepted in the response.
transaction_uuid | The transaction key for the request and response.  The requester may have several outstanding transactions, but must ensure that each transaction is unique per destination.  This **SHOULD** be a UUID, but the web router **SHALL** NOT validate this data.  The web router **SHALL** treat this data as opaque.
status | (optional) The response status to the originating service.  Not included in the during the request.
rdr | (optional) The `request delivery response` is the delivery result of the request message with a matching `transaction_uuid`.  The use case for this data is to provide a way for the system to indicate to the requesting agent that the message could not be delivered.
partner_ids | (optional) The list of partner ids the message is meant to target.  If the item is missing and the device has a `partner id` or the device does not find a match, the request shall be disregarded & a response with `status` of `403` sent back to the sender.
headers | (optional) The headers associated with the payload.
metadata | (optional) The map of name/value pairs used by consumers of WRP messages for filtering & other purposes.
spans | (optional) An array of arrays of timing values as a list in the format: "parent" (string), "name" (string), "start time" (int), "duration" (int), "status" (int)
span_parent | (optional) If the spans should be included, this field is included in the request.  This string is the root parent for the spans below to link to.
include_spans | (optional) (**Deprecated**) If the timing values should be included in the response.
qos | (optional) Indicates the quality of service to use for delivery of this event.
payload | The msgpack binary format packed data.


## Simple Event Definition

This is one of the primary message definitions used.  It provides a one
directional (no responses needed or sent) message from a component to whatever
happens to be listening.  It's a lot like a UDP message, but it's over TCP and
TLS.  Generally the `dest` is targeted to an `event:some_event_type_here/ignored`
which flows out to the event listeners for consumption.  This message type is
great at sending metrics, publishing a report, sending an SOS.

#### Schema

~~~~~
{
    Integer msg_type = 4
    String source
    String dest
    String content_type
    Array.String partner_ids
    Array.String headers
    Map[String] metadata
    Binary payload
    String session_id
    Integer qos
    String transaction_uuid
    Integer rdr
}
~~~~~

Name | Description
-----|--------------
msg_type | The message type for the simple event.  (**SHALL** be 4.)
source | The device_id name of the device originating the request or response.
dest | The device_id name of the target device of the request or response.
content_type | (optional) The media type of the payload.
partner_ids | (optional) The list of partner ids the message is meant to target.  If the item is missing and the device has a `partner id` or the device does not find a match, the request shall be disregarded.
headers | (optional) The headers associated with the payload.
metadata | (optional) The map of name/value pairs used by consumers of WRP messages for filtering & other purposes.
payload | The bin format packed data.
session_id | (optional) A unique ID for the device's connection session with XMiDT
qos | (optional) Indicates the quality of service to use for delivery of this event.
transaction_uuid | (optional, recommended) The transaction key for the request and possible ack.  The requester may have several outstanding transactions, but must ensure that each transaction is unique per destination.  This **SHOULD** be a UUID, but the web router **SHALL** NOT validate this data.  The web router **SHALL** treat this data as opaque.  This field is **REQUIRED** if the `qos` level requires an ack.
rdr | (optional) The `request delivery response` is the delivery result of the request message with a matching `transaction_uuid`.  The use case for this data is to provide a way for the system to indicate to the requesting agent that the message could not be delivered.

#### QOS Details

When a `qos` field is specified that requires an ack, the response ack message
SHALL be a `msg_type=4` (**Simple Event Definition**) event with the pertinent
details filled in.  These details are as follows, though additional details may
be added as appropriate.

    * The `source` SHALL be the component that cannot process the event further.
    * The `dest` SHALL be the original requesting `source` address.
    * The `content_type` and `payload` SHALL be omitted & set to empty, or may set to `application/text` and text to help describe the result.  **DO NOT** process this text beyond for logging/debugging.
    * The `partner_ids` SHALL be the same as the original message unless the Themis token has a different value. If there is a difference, the value of the Themis token will be used because the Themis token is a validated trust authority.
    * The `headers` SHOULD generally be the same as the original message, except where updating their values is correct.  Example: tracing headers should be honored & updated.
    * The `metadata` map SHALL be populated with the original data or set to empty.
    * The `session_id` MAY be added by the cloud.
    * The `qos` SHALL be the same as the original message.
    * The `transaction_uuid` SHALL be the same as the original message.
    * The `rdr` SHALL be present and represent the outcome of the handling of the message.

---
title: Simple Message Types
sort_rank: 3
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
between Webpa's `tr1d1um` machine and the `parodus2ccsp` client that interprets
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
payload | The msgpack binary format packed data.

#### Request Delivery Response (rdr) Codes:

    * 0 - Delivered
    * The rest are TBD today.


## Simple Event Definition

This is one of the primary message definitions used.  It provides a one
directional (no responses needed or sent) message from a component to whatever
happens to be listening.  It's alot like a UDP message, but it's over TCP and
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

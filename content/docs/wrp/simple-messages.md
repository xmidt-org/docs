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
to and from JSON and HTTP headers as well as its native msgpack format.

Messages currently flow in two directions:
- Inbound: API requests to devices.
- Outbound: responses from devices for corresponding inbound requests as well as
 events related to device activity (rebooting, updating, offline).
 
## Simple Request-Response Definition

This is one of the primary message definitions used.  This provides a point to
point (request, response) semantic between an API user that makes requests and 
a device client which responds to them.  An example of where this message is used is
between Webpa's `Tr1d1um` which sends requests on behalf of API users and the
 `Parodus2ccsp` client that interprets such requests, gathers data and responds back. 
 Both requests and responses use the same message type.

#### Schema
~~~~~
{
    Integer msg_type = 3
    String source
    String dest
    String device_id
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
source | The device_id name of the device originating the request or response (i.e. dns:tr1d1um.example.net for inbound messages).
dest | The device_id name of the target device of the request or response (i.e. mac:112233445566/config for inbound messages).
device_id | The canonical device ID (i.e. mac:112233445566) involved in this envelope. It defers from source or dest in that no further parsing is required to extract the ID from the value.
content_type | (optional) The media type of the payload. If not specified on inbound messages, `application/octet-stream` is used as default.
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
happens to be listening.  It's a lot like a UDP message, but it's over TCP and
TLS.  Generally the `dest` is targeted to an `event:some_event_type_here/ignored`
which flows out to the event listeners for consumption.  This message type is
great at sending metrics, publishing a report, sending an SOS.

#### Schema

~~~~~
{
    Integer msg_type = 4
    String source
    String content_type
    Array.String partner_ids
    Array.String headers
    Map[String] metadata
    Binary payload
    String sessionID
}
~~~~~

Name | Description
-----|--------------
msg_type | The message type for the simple event.  (**SHALL** be 4.)
source | The device_id name of the device originating the event (i.e. mac:112233445566/config)
dest | A value of the form: `event:{event-type}`. The main use case is the ability to listeners to register only for events they care about.
device_id | The canonical device ID (i.e. mac:112233445566) involved in this message. It defers from source as no further parsing is needed to extract the ID.
content_type | (optional) The media type of the payload. If not specified on inbound messages, `application/octet-stream` is used as default.
partner_ids | (optional) The list of partner ids the message is meant to target.  If the item is missing and the device has a `partner id` or the device does not find a match, the request shall be disregarded.
headers | (optional) The headers associated with the payload.
metadata | (optional) The map of name/value pairs used by consumers of WRP messages for filtering & other purposes.
payload | The bin format packed data.
sessionID | A unique ID for the device's connection session with XMiDT

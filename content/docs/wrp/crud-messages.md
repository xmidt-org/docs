---
title: CRUD Message Types
sort_rank: 40
---

# CRUD Message Types

CRUD (Create, Retrieve, Update, Delete) messages are a bit more advanced message
types, but are also extremely powerful and useful in the right context.

When you would like to replicate a RESTful interface CRUD messages let you do
that, but without the overhead associated with standing up an HTTP service,
piping things through to the outside world, etc.

The messages are delivered with the expectation that a response of some form
will be given (just like the Simple Request-Response messages).  In addition
to the delivery your code also gets the verb describing what to do based on
the message.

## CRUD Message Definition

#### Schema

~~~~~
{
    Integer msg_type = ( 5 | 6 | 7 | 8 )
    String source
    String dest
    String transaction_uuid
    String content_type
    String accept
    Array.String partner_ids
    Array.String headers
    Map[String] metadata
    Array.Array spans
    Boolean include_spans
    Integer status
    Integer rdr
    String path
    Binary payload
}
~~~~~

Name | Description
-----|--------------
msg_type | The message type for the CRUD interface.  (5 = Create, 6 = Retrieve, 7 = Update, 8 = Delete)
source | The originating point of the request or response.
dest | The destination point of the request or response.
transaction_uuid | The transaction key for the request and response.  The requester may have several outstanding transactions, but must ensure that each transaction is unique per destination.  This **SHOULD** be a UUID, but the web router **SHALL** NOT validate this data.  The web router **SHALL** treat this data as opaque.
content_type | (optional) The media type of the payload.
accept | (optional) The media type accepted in the response.
partner_ids | (optional) The list of partner ids the message is meant to target.  If the item is missing and the device has a `partner id` or the device does not find a match, the request shall be disregarded & a response with `status` of `403` sent back to the sender.
headers | (optional) The headers associated with the payload.
metadata | (optional) The map of name/value pairs used by consumers of WRP messages for filtering & other purposes.
spans | (optional) An array of arrays of timing values as a list in the format: "parent" (string), "name" (string), "start time" (int), "duration" (int), "status" (int)
span_parent | (optional) If the spans should be included, this field is included in the request.  This string is the root parent for the spans below to link to.
include_spans | (optional) (**Deprecated**) If the timing values should be included in the response.
status | (optional) The response status from the originating service.  Not included in the during the request.
rdr | (optional) The `request delivery response` is the delivery result of the previous (implied request) message with a matching `transaction_uuid`.
path | The path to which to apply the payload.
payload | (optional) The json encoded string representing the objects.

#### Payload Usage

Method | Request | Response
---------|---------|-----------
Create   | Name/value pairs for the new object | Resulting object
Retrieve | Ignored | Requested object
Update   | Name/value pair to update | Ignored
Delete   | Ignored | Ignored

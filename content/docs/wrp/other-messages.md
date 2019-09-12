---
title: Other Message Types
sort_rank: 50
---

# Other Message Types

These are the less commonly used messages.

## Authorization Status Definition

This message type is designed to not be route-able beyond the communication channel
bridging two components.

#### Schema
~~~~~
{
    Integer msg_type = 2
    Integer status
}
~~~~~

Name | Description
-----|--------------    
msg_type |The message type for the authorization status message.  (**SHALL** be 2.)
status | The status of the device to which the message is sent.

#### Status Codes

- 200 - Authorized
- 401 - Unauthorized - The service is not authorized for this account.
- 402 - Payment Required - The associated account needs payment.
- 406 - Not Acceptable - The certificate is not accepted.

## On Device Service Registration Message Definition

This message is used by services running on a CPE that wish to register for
messages from the Xmidt cluster.  This message is not able to be routed beyond
the immediate connection it is flowing across.

#### Schema
~~~~~
{
    Integer msg_type = 9
    String service_name
    String url
}
~~~~~

Name | Description
-----|--------------
msg_type | The message type for the on-device service registration
service_name | The originating point of the request or response
url | The url to use when connecting to the nanomsg pipeline

## On Device Service Alive Message Definition

This message is used by on device services to indicate that a service and
pipe are still alive.  This message is not able to be routed beyond the
immediate connection it is flowing across.

#### Schema
~~~~~
{
    Integer msg_type = 10
}
~~~~~

Name | Description
-----|--------------
msg_type | The message type for the on-device service alive update

## Unknown Message Definition

This message is used to represent a message that was lost, missing or otherwise
unable to be presented but that there was an event.  Generally this message
would be returned with a list of other WRP messages to show partial data loss
versus omitting the message existence.

~~~~~
{
    Integer msg_type = 11
}
~~~~~

Name | Description
-----|--------------
msg_type | The message type for the non-route-able unknown message


## Deprecated Messages

The following messages have been deprecated and **SHALL NOT** be used.

- 0
- 1

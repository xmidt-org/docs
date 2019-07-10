---
title: Overview
sort_rank: 1
---

# Overview

Xmidt has a few design requirements that both set it apart from other solutions
as well as imposes several needs.  Based on the needs enumerated below, the
message envelope named WRP was defined.  WRP is short for
**Web Routing Protocol** since there are also a few semantics that go along with
the envelope.

### Must provide a mechanism for routing
At the core, the Xmidt

### Span communication protocols
Data must consistently and easily span at least the following communication
protocols:

- websocket
- http
- socket

It needs to both span the protocols as well not require transformations.

### The payload may not be altered
Even if the payload is binary, text, malformed JSON or invalid msgpack the
payload must be delivered without alteration.

### Fast, simple & expandable
However the requirements are met, they must be met in such a way as to enable
simplicity, be fast and expandable for when new needs are discovered.



The resulting envelope is defined as a [msgpack](https://msgpack.org) map with
a number of required or optional parameters.

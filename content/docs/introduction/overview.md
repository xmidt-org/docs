---
title: Overview
sort_rank: 10
---

# Overview

## What is XMiDT?

XMiDT is a message routing and delivery platform designed to scale to millions
of connected clients and billions of messages delivered daily.

### Features

* a highly portable Linux client [Parodus](link) that provides a simple device integration experience
* a cloud infrastructure designed to be highly available
* each cloud component is individually scalable providing granular control
* the cloud infrastructure is designed to be nearly unlimited in the size

### Architecture

This diagram illustrates the architecture of the XMiDT core routing cloud:

![XMiDT core routing architecture](/assets/xmidt_core.png)

### Components

The XMiDT core routing cloud consists of several components.

 * Talaria - secure web socket termination server
 * Petasos - HTTP redirector for CPE devices
 * Scytale - api service front end
 * Caduceus - event delivery servicing agent
 * Issuer - (optional) JWT issuer for authentication and authorization
 * [Consul](https://www.consul.io/) - coordination service by HashiCorp
 * [Prometheus](https://www.prometheus.io/) - (optional) metrics gathering
 * [Trickster](https://github.com/Comcast/trickster) - (optional) metrics optimization

### When does it fit?

XMiDT is designed to provide message delivery to **lots** of continuously connected
devices.  XMiDT makes the cloud easier for CPE devices to participate in at
scale and makes the cloud interactions with the CPE devices more cloud friendly.

If you have a large (or potentially large) number of clients that can exist
behind firewalls, NATs or other infrastructure you need to operate, XMiDT can
be a good match.  The CPE devices do not need to expose services like telnet,
SSH, SNMP or others that can be compromised.  Instead, the XMiDT client (Parodus)
reaches out to your cloud via a known URL and securely ensures it is connected
only to your cluster.

XMiDT provides a highly scalable and cost effective solution to device management.

### When does it not fit?

XMiDT is not designed to replace streaming protocols (like WebRTC or streaming
audio/video).

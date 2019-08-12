---
title: Overview
sort_rank: 1
---

# Overview

Webpa is a translation service that provides a RESTful interface for the TR-181
(TR-104, etc) and similar data models present on some devices.

## A Bit of History

Originally, Webpa was a combination of the core routing of Xmidt and the RESTful
translation of TR-181.  This was done to reduce the amount of project risk.
Shortly after the first large scale deployment the team determined we should
split the translation layer off as a separate micro service.

The core routing portions of the project reside under the Xmidt project and the
translation portion (as well as a few other compatibility features) became Webpa.

### Benefits

The first and most valuable benefit for the teams developing Xmidt is that they
also have a real customer of that API.  This is valuable because often issues
are not perceived the same way on two sides of an API and being active consumers
enables us to solve the problems that Xmidt customers may encounter.

## Architecture

This diagram illustrates the architecture of the Webpa cloud and it's internals:

![Webpa architecture](/assets/webpa.png)

### When does it fit?

If you are interested in accessing TR-181 objects (or similar TR-xxx spec), this
is the right service for you.

### When does it not fit?

If you want to do something that isn't TR-181 related (like talk to Aker for
instance) this is not the right service for you.

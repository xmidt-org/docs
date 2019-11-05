---
title: Comparison to alternatives
sort_rank: 30
---

# Comparisons

We are often asked how Xmidt+Webpa compares to some alternative.  It's a great
question.  By itself Xmidt is difficult to compare directly to other systems
primarily due to the fundamental differences in architecture & different project
goals.

Xmidt by design is **not** coupled with any data models.
This allows for inclusion of all manor of data models.  TR-181, TR-104, custom
Msgpack or JSON are all no problem.  Any system tightly coupled with one of the
`TR-181` | `TR-104` | `TR-357` | etc, fundamentally couple the service life of
the entire ecosystem to the use of these particular models.  Xmidt's architecture
is designed to avoid this coupling.  None of the other existing services have
this design goal as a core system value.

Xmidt, Webpa, Codex and the ecosystem are designed to be an 'à la carte'
solution.  This includes the cloud components, the client components and the
data models available.  You get the choice of which services you want to deploy.
The service you need may be to access the existing TR-181 or TR-104 data
model on your device (Webpa+Webpa Client).  It may be an alternative cloud
managed event scheduler (Aker Client) or something that is custom and
proprietary to your needs.

The Xmidt community's focus is to give you the easy to use building blocks so
you can best assemble the system that works best for your use cases.

# Comparison Table of Xmidt+Webpa to TR-069+ACS & USP

To help provide a basic comparison between the 3 solutions we usually get
questions about, we are limited the scope to just TR-181 or similar access.

TR-069 and USP/TR-369 appear only available as proprietary only solution end
to end.


| Category                                                          | TR-069<sup>[2]</sup>                         | USP<sup>[2]</sup>                             | Xmidt+Webpa |
|:------------------------------------------------------------------|:--------------------------------------------:|:---------------------------------------------:|:----------------------------------------:|
|End-to-End Open Source Solution                                    | <i class="fas fa-times-circle no"></i>       | <i class="fas fa-times-circle no"></i>        |  <i class="fas fa-check-circle yes"></i> |
|All Components Available via Business Friendly Apache 2.0 License  | <i class="fas fa-times-circle no"></i>       | <i class="fas fa-times-circle no"></i>        |  <i class="fas fa-check-circle yes"></i> |
|Zero Licensing Costs                                               | <i class="fas fa-times-circle no"></i>       | <i class="fas fa-times-circle no"></i>        |  <i class="fas fa-check-circle yes"></i> |
|Inclusive and Extensible Ecosystem at Client or Server Levels      | <i class="fas fa-times-circle no"></i>       | <i class="fas fa-times-circle no"></i>        |  <i class="fas fa-check-circle yes"></i> |
|Supports Multiple Management Servers                               | <i class="fas fa-times-circle no"></i>       | <i class="fas fa-check-circle yes"></i>       |  <i class="fas fa-check-circle yes"></i> |
|Has Efficient Data Encoding                                        | <i class="fas fa-times-circle no"></i>       | <i class="fas fa-check-circle yes"></i>       |  <i class="fas fa-check-circle yes"></i> |
|Has an Always-On Communication Mechanism                           | <i class="fas fa-times-circle no"></i>       | <i class="fas fa-check-circle yes"></i>       |  <i class="fas fa-check-circle yes"></i> |
|Utilizes a Device:2 (TR-181i2) Driven Data Model                   | <i class="fas fa-times-circle no"></i>       | <i class="fas fa-check-circle yes"></i>       |  <i class="fas fa-check-circle yes"></i> |
|Schema Drive Protocol Definition                                   | <i class="fas fa-check-circle yes"></i>      | <i class="fas fa-check-circle yes"></i>       |  <i class="fas fa-check-circle yes"></i> |
|Defines a Robust Set of Operations                                 | <i class="fas fa-check-circle yes"></i>      | <i class="fas fa-check-circle yes"></i>       |  <i class="fas fa-check-circle yes"></i> |
|May Leverage a Transport Layer Security Mechanism                  | <i class="fas fa-check-circle yes"></i>      | <i class="fas fa-check-circle yes"></i>       |  <i class="fas fa-check-circle yes"></i> |
|Provides an Access Control Mechanism<sup>[1]</sup>                 | 1/2                                          | <i class="fas fa-check-circle yes"></i>       |  <i class="fas fa-check-circle yes"></i> |
|Provides a Secure Clean/Screen Solution for 3rd Party Services     | <i class="fas fa-times-circle no"></i>       | <i class="fas fa-times-circle no"></i>        |  <i class="fas fa-check-circle yes"></i> |
|Easy to Scale (100 - +50M CPEs)<sup>[3]</sup>                      | <i class="fas fa-times-circle no"></i>       | <i class="fas fa-question-circle maybe"></i>  |  <i class="fas fa-check-circle yes"></i> |
|Easy to Scale (100 - +100K events/second)<sup>[3]</sup>            | <i class="fas fa-times-circle no"></i>       | <i class="fas fa-question-circle maybe"></i>  |  <i class="fas fa-check-circle yes"></i> |
|Upgradable Without Outages at Scale<sup>[3]</sup>                  | <i class="fas fa-question-circle maybe"></i> | <i class="fas fa-question-circle maybe"></i>  |  <i class="fas fa-check-circle yes"></i> |
|Functions Properly With Complete Datacenter Failure<sup>[3]</sup>  | <i class="fas fa-question-circle maybe"></i> | <i class="fas fa-question-circle maybe"></i>  |  <i class="fas fa-check-circle yes"></i> |


Notes:

* `[1]` - This is an optional 'à la carte' Xmidt feature where one available approach is to use `partner-id`.
* `[2]` - Depends on your vendor.
* `[3]` - Xmidt behavior confirmed by the Comcast team.

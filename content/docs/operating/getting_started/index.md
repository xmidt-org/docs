---
title: Getting started
sort_rank: 1
---

# Getting Started
The orchestration of XMiDT can be quite complicated. Please refer to the [architecture](../introduction/index.md)
to have a better understanding of the components and how they work towards the bigger picture.

If you want something up and running now to see how components connect, use [docker-compose](https://github.com/xmidt-org/xmidt/tree/master/deploy/docker-compose).


## Before you begin
You need to decide how to routing is going to work from petasos to talaria.
Currently there are two main options: `fixed` and `consul`.
We recommend consul because scaling is easier

## Fixed
Fixed is having all the talaria's hardcoded for each server

| Pro                          | Con                                                  |
|------------------------------|------------------------------------------------------|
| Fast to standup              | Scaling is harder                                    |
| One less component to manage | Nodes falling over can't be removed from the cluster |

### Setup
This step will be done at each service level, by providing a list of urls.

## Consul
[Consul](https://www.consul.io/) allows petasos to know about all the talaria's in the datacenter

| Pro                           | Con                            |
|-------------------------------|--------------------------------|
| Scaling is fast and easy      | TLS can be more complicated    |
| Make metric monitoring easier | You will have to manage consul |

### Setup
-   [Installation](https://learn.hashicorp.com/consul/getting-started/install)
-   [TLS Setup](https://www.digitalocean.com/community/tutorials/how-to-secure-consul-with-tls-encryption-on-ubuntu-14-04)


# Next
Once you have your approach, and it is up and running you can standup [Talaria](../talaria)

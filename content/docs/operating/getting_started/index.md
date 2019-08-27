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
We recommend consul, which helps with horizontal scaling.

## Fixed
Fixed routing involves configuring each petasos to know the fqdn/ip of all talarias in the cluster/region.```

| Pro                          | Con                         |
|------------------------------|-----------------------------|
| Fast to standup              | Scaling is harder           |
| One less component to manage | Node failover not supported |

### Setup
No prior setup is necessary.
This step will be done at each service level, by providing a list of urls.

## Consul
[Consul](https://www.consul.io/) allows petasos to dynamically know about all the talarias in the datacenter.

| Pro                       | Con                            |
|---------------------------|--------------------------------|
| Scaling is fast and easy  | TLS can be more complicated    |
| Easier metric monitoring  | Management of Consul           |

### Setup
-   [Installation](https://learn.hashicorp.com/consul/getting-started/install)
-   [TLS Setup](https://www.digitalocean.com/community/tutorials/how-to-secure-consul-with-tls-encryption-on-ubuntu-14-04)


# Next
Once you have your approach, and it is up and running you can standup [Talaria](/docs/operating/getting_started/talaria).

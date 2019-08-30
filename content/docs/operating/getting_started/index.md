---
title: Getting started
sort_rank: 1
---

# Getting Started
The orchestration of XMiDT can be quite complicated. Please refer to the [architecture](../introduction/index.md)
to have a better understanding of the components and how they work towards the bigger picture.

To get up and running quickly, or for a small, non-high availability instance we have
a [docker-compose](https://github.com/xmidt-org/xmidt/tree/master/deploy/docker-compose) version available.  
This is a great way to see how the components connect with one another as well as a sample configuration
for each machine that works together.


## Cluster composition determination
The XMiDT cluster can be configured either to dynamically coordinate via Consul (`consul` option)
or be statically configured (`fixed` option).  The coordination defines how Petasos routes traffic to Talaria
machines as well as ensuring Talaria machines accept the same traffic.  At all times Petasos and Talaria should
be in lock-step to prevent inbound connections from possibly being stranded.  For any production or
production-like instances we recommend the `consul` option.

## Fixed
Fixed routing involves configuring each petasos to know the fqdn/ip of all talarias in the cluster/region.

| Pro                          | Con                         |
|------------------------------|-----------------------------|
| Fast to standup              | Scaling is harder           |
| One less component to manage | Node failover not supported |
|                              | Prometheus auto-discovery is harder |


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

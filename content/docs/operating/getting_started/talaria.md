---
title: Talaria
sort_rank: 2
---

# Talaria

# Installation
-   [RPM](https://xmidt.io/download/#talaria)
-   [Binary](https://xmidt.io/download/#talaria)
-   Docker (Link TBC)

# Configuration
Refer to [configuration file](https://github.com/xmidt-org/talaria/blob/master/talaria.yaml)
for how to configure talaria.

## Fixed
For fixed routing, the service block in talaria's configuration should look similar to the example below:

```yaml
service:
  defaultScheme: http
  fixed:
    - http://<HOSTNAME>:6200
```
Where HOSTNAME is your DNS record, docker container, or ip address.

_**NOTE**_: if you have domain or host certificates available, we recommend
always running the service (and all components in the service) in https mode.

## Consul
For a consul managed list of talarias, the service block in talaria's configuration should look similar to the example below:

```yaml
service:
  defaultScheme: http
  consul:
    client:
      address: "CONSUL_ADDRESS:8500"
      scheme: "http"
      waitTime: "30s"
    disableGenerateID: true
    vnodeCount: 211
    watches:
      -
        service: "talaria"
        tags:
          - "dev"
          - "docker"
        passingOnly: true
    registrations:
      -
        id: "HOSTNAME"
        name: "talaria"
        tags:
          - "dev"
          - "docker"
          - "stage=dev"
          - "flavor=docker"
        address: "http://HOSTNAME"
        scheme: "http"
        port: 6210
        checks:
          -
            checkID: "talaria-1:http"
            http: "http://HOSTNAME:HEALTH_PORT/health"
            interval: "30s"
            deregisterCriticalServiceAfter: "70s"
```
Talaria is watching for the other talarias and is registering itself.

_**NOTE**_: if you have certs available, change http to https. HTTP should never
be run in production.

# Validation
## Test Health
```bash
curl HOSTNAME:HEALTH_PORT/health -i
```


```
$ curl localhost:6201/health -i
HTTP/1.1 200 OK
Content-Type: application/json
X-Talaria-Build: development
X-Talaria-Flavor: development
X-Talaria-Region: local
X-Talaria-Server: localhost
X-Talaria-Start-Time: 26 Aug 19 18:43 UTC
Date: Mon, 26 Aug 2019 18:44:30 GMT
Content-Length: 497
Connection: close

{"CurrentMemoryUtilizationActive":931160064,"CurrentMemoryUtilizationAlloc":2907696,"CurrentMemoryUtilizationHeapSys":66093056,"DeviceCount":0,"MaxMemoryUtilizationActive":931160064,"MaxMemoryUtilizationAlloc":3649496,"MaxMemoryUtilizationHeapSys":66125824,"TotalConnectionEvents":0,"TotalDisconnectionEvents":0,"TotalPingMessagesReceived":0,"TotalPongMessagesReceived":0,"TotalRequestsDenied":0,"TotalRequestsReceived":0,"TotalRequestsSuccessfullyServiced":0,"TotalWRPRequestResponseProcessed":0}
```

## Test Device Connection
Using a [simulator](https://github.com/xmidt-org/xmidt/tree/master/simulator) we
can mock a device connecting to our cluster. Or you can do hands on with [kratos](https://github.com/xmidt-org/kratos).

```bash
docker run -e URL=http://HOSTNAME:PRIMARY_PORT rdkb-simulator
```
Where HOSTNAME is your DNS record, docker container, or ip address.
_**NOTE**_: If you are running talaria locally, you will need to provide the ip
address of your machine.

Get Connected Devices
_**NOTE**_: This is a very expensive command. Do NOT run it in production.

```bash
curl -i -H "Authorization: Basic AUTHOKEN" HOSTNAME:PRIMARY_PORT/api/v2/devices
```
Where HOSTNAME is your DNS record, docker container, or ip address.
Where AUTHOKEN is the `inbound.authKey"` in the yaml configuration file.

The following is an example. Do not use this auth key in production.

```bash
$ curl -i -H "Authorization: Basic dXNlcjpwYXNz" http://localhost:6200/api/v2/devices
HTTP/1.1 200 OK
Content-Type: application/json
X-Talaria-Build: development
X-Talaria-Flavor: development
X-Talaria-Region: local
X-Talaria-Server: localhost
X-Talaria-Start-Time: 26 Aug 19 18:43 UTC
Date: Mon, 26 Aug 2019 18:57:54 GMT
Content-Length: 245

{"devices":[{"id": "mac:112233445566", "pending": 0, "statistics": {"bytesSent": 0, "messagesSent": 0, "bytesReceived": 0, "messagesReceived": 0, "duplications": 0, "connectedAt": "2019-08-26T18:43:57.666272023Z", "upTime": "13m56.48957368s"}}]}
```

# Troubleshooting
The most common error is [devices not showing](/docs/operating/troubleshooting/#device-is-not-showing-up-in-cluster-talaria).

# Next
Talaria should be up and running now; let's stand up [petasos](/docs/operating/getting_started/petasos).

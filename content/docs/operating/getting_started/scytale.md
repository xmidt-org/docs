---
title: Scytale
sort_rank: 4
---

# Scytale

# Installation
-   [RPM](https://github.com/xmidt-org/scytale/releases)
-   [Binary](https://github.com/xmidt-org/scytale/releases)
-   Docker (Link TBC)

# Configuration
Refer to [configation file](https://github.com/xmidt-org/scytale/blob/master/example-scytale.yaml)
for how to configure scytale.

## Fixed
Under the fanout block of the yaml file you will have

```yaml
fanout:
  endpoints: [ "https://petasos:6400/api/v2/device/send" ]
  authorization: dXNlcjpwYXNz
  fanoutTimeout: "127s"
  clientTimeout: "127s"
  concurrency: 10
```
Where HOSTNAME is you DNS record, docker container, or ip address.

_**NOTE**_: if you have certs available change http to https. HTTP should never
be run in production.

_**NOTE**_: dXNlcjpwYXNz is an example auth string for petasos. DO NOT use
this in production.

# Validation
## Test Health
```bash
curl HOSTNAME:HEALTH_PORT/health -i
```


```
$ curl -i localhost:6301/health
HTTP/1.1 200 OK
Content-Type: application/json
X-Scytale-Build: development
X-Scytale-Flavor: development
X-Scytale-Region: local
X-Scytale-Server: localhost
X-Scytale-Start-Time: 26 Aug 19 18:43 UTC
Date: Mon, 26 Aug 2019 19:45:37 GMT
Content-Length: 427
Connection: close

{"CurrentMemoryUtilizationActive":903426048,"CurrentMemoryUtilizationAlloc":1711536,"CurrentMemoryUtilizationHeapSys":66224128,"MaxMemoryUtilizationActive":946319360,"MaxMemoryUtilizationAlloc":3915152,"MaxMemoryUtilizationHeapSys":66289664,"PayloadsOverHundred":0,"PayloadsOverTenThousand":0,"PayloadsOverThousand":0,"PayloadsOverZero":0,"TotalRequestsDenied":0,"TotalRequestsReceived":0,"TotalRequestsSuccessfullyServiced":0}
```

## Test Device
Using a [simulator](https://github.com/xmidt-org/xmidt/tree/master/simulator) we
can mock a device connecting to our cluster. Or you can do hands on with [kratos](https://github.com/xmidt-org/kratos)

```bash
docker run -e URL=http://PETASOS_HOSTNAME:PETASOS_PRIMARY_PORT rdkb-simulator
```

```bash
curl -i -H "Authorization: Basic authHeader" localhost:6400/api/v2/device/stat
```

```
$ curl -i -H "Authorization: Basic dXNlcjpwYXNz" localhost:6300/api/v2/device/mac:112233445566/stat
HTTP/1.1 200 OK
Content-Length: 233
Content-Type: application/json
X-Scytale-Build: development
X-Scytale-Flavor: development
X-Scytale-Region: local
X-Scytale-Server: localhost
X-Scytale-Start-Time: 26 Aug 19 18:43 UTC
X-Talaria-Build: development
X-Talaria-Flavor: development
X-Talaria-Region: local
X-Talaria-Server: localhost
X-Talaria-Start-Time: 26 Aug 19 18:43 UTC
X-Xmidt-Span: "http://petasos:6400/api/v2/device/mac:112233445566/stat","2019-08-26T19:52:10Z","4.640508ms"
Date: Mon, 26 Aug 2019 19:52:10 GMT

{"id": "mac:112233445566", "pending": 0, "statistics": {"bytesSent": 0, "messagesSent": 0, "bytesReceived": 0, "messagesReceived": 0, "duplications": 0, "connectedAt": "2019-08-26T18:43:57.666272023Z", "upTime": "1h8m12.684567688s"}}
```

# Troubleshooting
-   Received a 404 status code
    -   The Device is not connected to the cluster

# Next
scytale is up and running now, let's stand up [tr1d1um](../tr1d1um).

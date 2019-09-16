---
title: Scytale
sort_rank: 40
---

# Scytale

# Installation
-   [RPM](https://xmidt.io/download/#scytale)
-   [Binary](https://xmidt.io/download/#scytale)
-   Docker (Link TBC)

# Configuration
Refer to [configuration file](https://github.com/xmidt-org/scytale/blob/master/scytale.yaml)
for how to configure scytale.

## Connecting to petasos
To provide the petasoses that scytale should connect to, the fanout block in scytale's configuration should look similar to the example below:

```yaml
fanout:
  endpoints: [ "https://PETASOS_HOSTNAME:PRIMARY_PORT/api/v2/device/send" ]
  authorization: dXNlcjpwYXNz
  fanoutTimeout: "127s"
  clientTimeout: "127s"
  concurrency: 10
```
Where `PETASOS_HOSTNAME` is your Petasos DNS record, docker container, or ip address listening on the
`PRIMARY_PORT`.

_**NOTE**_: if you have domain or host certificates available, we recommend
always running the service (and all components in the service) in https mode.

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
Connect a device to talaria, described [here](/docs/operating/getting_started/talaria/#test-device-connection).

```bash
curl -i -H "Authorization: Basic AUTHOKEN" HOSTNAME:PRIMARY_PORT/api/v2/device/DEVICE_ID/stat
```
Where `HOSTNAME` is your DNS record, docker container, or ip address listening on the
`PRIMARY_PORT`. Where `AUTHOKEN` is the `authHeader` in the yaml configuration file.
Where `DEVICE_ID` is the device that is connected to talaria.

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
The most common error is getting a 404, meaning the [device is not connected](/docs/operating/troubleshooting/#device-is-not-showing-up-in-cluster-talaria) to the cluster.

# Next
scytale is up and running now; let's stand up [tr1d1um](/docs/operating/tr1d1um).

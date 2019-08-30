---
title: Tr1d1um
sort_rank: 5
---

# Tr1d1um

# Installation
-   [RPM](https://github.com/xmidt-org/tr1d1um/releases)
-   [Binary](https://github.com/xmidt-org/tr1d1um/releases)
-   Docker (Link TBC)

# Configuration
Refer to [configuration file](https://github.com/xmidt-org/tr1d1um/blob/master/tr1d1um.yaml)
for how to configure tr1d1um.

## Connecting to scytale
Under the fanout block of the yaml file you will have

```yaml
targetURL: http://SCYTALE_HOSTNAME:PRIMARY_PORT
```
Where HOSTNAME is you DNS record or docker container or ip address.

_**NOTE**_: if you have certs available, change http to https. HTTP should never
be run in production.

_**NOTE**_: dXNlcjpwYXNz is an example auth string for tr1d1um. DO NOT use
this in production.

# Validation
## Test Health
```bash
curl HOSTNAME:HEALTH_PORT/health -i
```


```
$ curl -i localhost:6101/health
HTTP/1.1 200 OK
Content-Type: application/json
X-Tr1d1um-Build: development
X-Tr1d1um-Flavor: development
X-Tr1d1um-Region: local
X-Tr1d1um-Server: localhost
X-Tr1d1um-Start-Time: 26 Aug 19 18:43 UTC
Date: Mon, 26 Aug 2019 19:58:13 GMT
Content-Length: 427
Connection: close

{"CurrentMemoryUtilizationActive":905760768,"CurrentMemoryUtilizationAlloc":3218168,"CurrentMemoryUtilizationHeapSys":66289664,"MaxMemoryUtilizationActive":946307072,"MaxMemoryUtilizationAlloc":3881600,"MaxMemoryUtilizationHeapSys":66322432,"PayloadsOverHundred":0,"PayloadsOverTenThousand":0,"PayloadsOverThousand":0,"PayloadsOverZero":0,"TotalRequestsDenied":0,"TotalRequestsReceived":0,"TotalRequestsSuccessfullyServiced":0}
```

## Test Device
Connect a device to talaria, described [here](/docs/operating/getting_started/talaria/#test-device-connection)

```bash
curl -i -H "Authorization: Basic AUTHOKEN" HOSTNAME:PRIMARY_PORT/api/v2/device/DEVICE_ID/stat
```
Where HOSTNAME is you DNS record, docker container, or ip address.
Where AUTHOKEN is the `authHeader` in the yaml configuration file
Where DEVICE_ID is the device that is connect to talaria.

```
$ curl -i -H "Authorization: Basic dXNlcjpwYXNz" localhost:6100/api/v2/device/mac:112233445566/stat
HTTP/1.1 200 OK
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
X-Tr1d1um-Build: development
X-Tr1d1um-Flavor: development
X-Tr1d1um-Region: local
X-Tr1d1um-Server: localhost
X-Tr1d1um-Start-Time: 26 Aug 19 18:43 UTC
X-Webpa-Transaction-Id: t9KunHNKoH5mpx2CcsMLRA
X-Xmidt-Span: "http://petasos:6400/api/v2/device/mac:112233445566/stat","2019-08-26T20:01:51Z","3.375186ms"
Date: Mon, 26 Aug 2019 20:01:51 GMT
Content-Length: 234

{"id": "mac:112233445566", "pending": 0, "statistics": {"bytesSent": 0, "messagesSent": 0, "bytesReceived": 0, "messagesReceived": 0, "duplications": 0, "connectedAt": "2019-08-26T18:43:57.666272023Z", "upTime": "1h17m54.056809601s"}}
```

# Troubleshooting
The most common error is getting a 404, meaning the [device is not connected](/docs/operating/troubleshooting/#device-is-not-showing-up-in-cluster-talaria) to the cluster.

# Next
tr1d1um is up and running now; let's stand up [caduceus](/docs/operating/getting_started/caduceus).

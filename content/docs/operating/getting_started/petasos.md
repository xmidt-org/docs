---
title: Petasos
sort_rank: 3
---

# Petasos

# Installation
-   [RPM](https://github.com/xmidt-org/petasos/releases)
-   [Binary](https://github.com/xmidt-org/petasos/releases)
-   Docker (Link TBC)

# Configuration
Refer to [configuration file](https://github.com/xmidt-org/petasos/blob/master/example-petasos.yaml)
for how to configure petasos.

## Fixed
For fixed routing, the service block in petasos' configuration should look similar to the example below:

```yaml
service:
  defaultScheme: http
  fixed:
    - http://HOSTNAME:PRIMARY_PORT
    - http://HOSTNAME:PRIMARY_PORT
```
Where HOSTNAME is your DNS record, docker container, or ip address.

_**NOTE**_: if you have certs available change http to https. HTTP should never
be run in production.

## Consul
For a consul managed list of talarias, the petasos configuration should look similar to the example below:

```yaml
service:
  defaultScheme: http
  consul:
    client:
      address: "CONSUL_ADDRESS:8500"
      scheme: "http"
      waitTime: "30s"
    disableGenerateID: true
    watches:
      -
        service: "talaria"
        passingOnly: true
    vnodeCount: 211
```
Petasos is now using consul to watch for talarias.

_**NOTE**_: if you have certs available, change http to https. HTTP should never
be run in production.

# Validation
## Test Health
```bash
curl HOSTNAME:HEALTH_PORT/health -i
```


```
$ curl -i localhost:6401/health -i
HTTP/1.1 200 OK
Content-Type: application/json
X-Petasos-Build: development
X-Petasos-Flavor: development
X-Petasos-Region: local
X-Petasos-Server: localhost
X-Petasos-Start-Time: 26 Aug 19 18:43 UTC
Date: Mon, 26 Aug 2019 19:32:48 GMT
Content-Length: 427
Connection: close

{"CurrentMemoryUtilizationActive":900415488,"CurrentMemoryUtilizationAlloc":3725928,"CurrentMemoryUtilizationHeapSys":66224128,"MaxMemoryUtilizationActive":946319360,"MaxMemoryUtilizationAlloc":3814840,"MaxMemoryUtilizationHeapSys":66322432,"PayloadsOverHundred":0,"PayloadsOverTenThousand":0,"PayloadsOverThousand":0,"PayloadsOverZero":0,"TotalRequestsDenied":0,"TotalRequestsReceived":0,"TotalRequestsSuccessfullyServiced":0}
```

## Test Device Redirection
```bash
curl -i -H "X-Webpa-Device-Name: DEVICE_ID"  http://HOSTNAME:PRIMARY_PORT/api/v2/device
```

```bash
$ curl -i  -H "X-Webpa-Device-Name:mac:112233445566" localhost:6400/api/v2/device
HTTP/1.1 307 Temporary Redirect
Content-Type: text/html; charset=utf-8
Location: http://talaria-0:6200/api/v2/device
X-Petasos-Build: development
X-Petasos-Flavor: development
X-Petasos-Region: local
X-Petasos-Server: localhost
X-Petasos-Start-Time: 26 Aug 19 18:43 UTC
Date: Mon, 26 Aug 2019 19:35:12 GMT
Content-Length: 71

<a href="http://talaria-0:6200/api/v2/device">Temporary Redirect</a>.
```

# Troubleshooting


# Next
Petasos is up and running now, lets stand up [scytale](../scytale)

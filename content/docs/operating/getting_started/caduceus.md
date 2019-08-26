---
title: Caduceus
sort_rank: 6
---

# Caduceus
Currently Caduceus depends on [SNS](https://aws.amazon.com/sns/getting-started/)

# Installation
-   [RPM](https://github.com/xmidt-org/caduceus/releases)
-   [Binary](https://github.com/xmidt-org/caduceus/releases)
-   Docker (Link TBC)

# Configuration
Refer to [configation file](https://github.com/xmidt-org/caduceus/blob/master/example-caduceus.yaml)
for how to configure caduceus.

## Fixed
Under the aws block of the yaml file you will have

```yaml
aws:
  accessKey: ""
  secretKey: ""
  env: local-dev
  sns:
    awsEndpoint: http://goaws:4100
    region: "us-east-1"
    topicArn: arn:aws:sns:us-east-1:000000000000:xmidt-local-caduceus
    urlPath: "/api/v2/aws/sns"
```
For local testing you can use [a mock sns instance](https://github.com/p4tin/goaws)
_**NOTE**_: Do not use this in production. It is untested.

# Validation
## Test Health
```bash
curl HOSTNAME:HEALTH_PORT/health -i
```


```
$ curl -i localhost:6001/health
HTTP/1.1 200 OK
Content-Type: application/json
X-Caduceus-Build: development
X-Caduceus-Flavor: development
X-Caduceus-Region: local
X-Caduceus-Server: localhost
X-Caduceus-Start-Time: 26 Aug 19 18:43 UTC
Date: Mon, 26 Aug 2019 20:10:28 GMT
Content-Length: 427
Connection: close

{"CurrentMemoryUtilizationActive":895574016,"CurrentMemoryUtilizationAlloc":3190504,"CurrentMemoryUtilizationHeapSys":66224128,"MaxMemoryUtilizationActive":946352128,"MaxMemoryUtilizationAlloc":3908816,"MaxMemoryUtilizationHeapSys":66420736,"PayloadsOverHundred":0,"PayloadsOverTenThousand":0,"PayloadsOverThousand":0,"PayloadsOverZero":0,"TotalRequestsDenied":0,"TotalRequestsReceived":0,"TotalRequestsSuccessfullyServiced":0}
```


## Test Webhooks

### Get webhooks
```bash
curl -i -H "Authorization: Basic authHeader" localhost:6100/api/v2/device/stat
```

```
$ curl -i -H "Authorization: Basic dXNlcjpwYXNz" localhost:6000/hooks
HTTP/1.1 200 OK
Content-Type: application/json
X-Caduceus-Build: development
X-Caduceus-Flavor: development
X-Caduceus-Region: local
X-Caduceus-Server: localhost
X-Caduceus-Start-Time: 26 Aug 19 18:43 UTC
Date: Mon, 26 Aug 2019 20:12:36 GMT
Content-Length: 2

[]
```
_**NOTE**_: dXNlcjpwYXNz is an example auth string for caduceus. DO NOT use
this in production

### Register a webook
Create a [listener](https://github.com/xmidt-org/wrp-listener/blob/master/examples/configurableListener), you should see it by checking the `hooks` endpoint


### Testing webhook
Using a [simulator](https://github.com/xmidt-org/xmidt/tree/master/simulator) we
can mock a device connecting to our cluster. Or you can do hands on with [kratos](https://github.com/xmidt-org/kratos)

```bash
docker run -e URL=http://PETASOS_HOSTNAME:PETASOS_PRIMARY_PORT rdkb-simulator
```

Upon disconnect and connect you should see an offline and online event.


# Troubleshooting
-   Message is not received from listener
    -   Validate that the talaria's have the eventMap block and that it is pointing to the correct endpoint.
    ```yaml
      eventMap:
          default: http://CADUCEUS_HOSTNAME:PRIMARY_PORT/api/v3/notify
    ```


# Next
The Cluster is up and running. Take a look at [Codex](../../../codex/overview/) for how to build
a codex cluster.

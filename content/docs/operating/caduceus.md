---
title: Caduceus
sort_rank: 60
---

# Caduceus
Currently Caduceus depends on [SNS](https://aws.amazon.com/sns/getting-started/)

# Installation
-   [RPM](https://xmidt.io/download/#caduceus)
-   [Binary](https://xmidt.io/download/#caduceus)
-   Docker (Link TBC)

# Configuration
Refer to [configuration file](https://github.com/xmidt-org/caduceus/blob/master/caduceus.yaml)
for how to configure caduceus.

## Connecting to aws
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
curl -i HOSTNAME:HEALTH_PORT/health
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
curl -i -H "Authorization: Basic AUTHOKEN" HOSTNAME:PRIMARY_PORT/hooks
```
Where `HOSTNAME` is your DNS record, docker container, or ip address listening on the
`PRIMARY_PORT`. Where `AUTHOKEN` is the `authHeader` in the yaml configuration file.


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
this in production.

### Register a webhook
Create a [listener](https://github.com/xmidt-org/wrp-listener/blob/master/examples/configurableListener).  
You should see it by checking the `hooks` endpoint.


### Testing webhook
Connect a device to talaria, described [here](/docs/operating/getting_started/talaria/#test-device-connection).
When the device connects and disconnects to talaria, the listener should receive an online and offline event.


# Troubleshooting
The most common error is that talaria is [not configured correctly to talk to caduceus](/docs/operating/troubleshooting/#event-errors).


# Next
The Cluster is up and running. Take a look at [Codex](/docs/codex/overview/) for how to build
a codex cluster.

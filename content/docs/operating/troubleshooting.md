---
title: Troubleshooting
sort_rank: 100
---

# Troubleshooting

## Device Errors

### Device is not showing up in Cluster/Talaria

- Problem: Parados (the application of the device that connects to talaria) has the incorrect url.

  - Solution: Validate Parados has the correct url.

    ```bash
    docker run -e URL=http://HOSTNAME:PRIMARY_PORT rdkb-simulator
    # HOSTNAME should be either a talaria or petasos address, with
    # the correct corresponding PRIMARY_PORT
    ```

- Problem: TLS is inconsistent between talaria and petasos.

  - Fixed Solution: Change talaria and petasos configurations to be consistent with `http` or `https`.

    ```yaml
    # talaria  
    service:
      defaultScheme: http
      fixed:
        - http://TALARIA_HOSTNAME:PRIMARY_PORT
    # petasos
    service:
    defaultScheme: http
    fixed:
      - http://TALARIA_HOSTNAME:PRIMARY_PORT
    ```

  - Consul Solution: Change talaria and petasos Configuration to be consistent with `http` or `https`. `https` is default.

    ```yaml
    # talaria  
    service:
      defaultScheme: http
      # ^ important
      consul:
        client:
          address: "CONSUL_ADDRESS:CONSUL_API_PORT"
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
            address: "http://HOSTNAME:PRIMARY_PORT"
            # ^ important
            scheme: "http"
            # ^ important
            port: 6210
            checks:
              -
                checkID: "talaria-1:http"
                http: "http://HOSTNAME:HEALTH_PORT/health"
                interval: "30s"
                deregisterCriticalServiceAfter: "70s"


    # petasos
    service:
    defaultScheme: http
    # ^ important
    consul:
      client:
        address: "consul0:8500"
        scheme: "http"
        waitTime: "30s"
      disableGenerateID: true
      watches:
        -
          service: "talaria"
          passingOnly: true
      vnodeCount: 211
    ```

- Problem: Talaria is not registering with Consul.

  - Detection: On a consul node, run the following command(s):

    ```bash
    consul catalog services
    # talaria should show up in list, if not try the solution
    ```

  - Solution: Validate Consul client block in Talaria config, with TLS and address.

    ```yaml
    consul:
      client:
        address: "CONSUL_ADDRESS:CONSUL_API_PORT"
        # ^ important
        scheme: "http"
        # ^ important
        waitTime: "30s"
    ```

## Event Errors
- Problem: Caduceus is not receiving events.
  - Solution: Update the talaria yaml with the correct information.

    ```yaml
    eventMap:
        default: http://CADUCEUS_HOSTNAME:PRIMARY_PORT/api/v3/notify
          # double check http vs https and the hostname
    ```

# General Errors
- Problem: Docker networking with localhost.
  - Solution: Use the ip address of the host machine.
  You can not use `localhost` when working with docker.

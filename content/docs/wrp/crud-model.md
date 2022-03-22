---
title: CRUD Model Details
sort_rank: 60
---

# CRUD Model Details

The WRP CRUD model is configured as a set of read and write values that configure behavior and upstream filtering options.  Below is the plan for where the options are retrieved from and stored (if required).

Name | Type | Origin | In Convey Header? | Persisted In File?
-----|------|--------|-------------------|--------------------
`/hw-model` | string | command-line `--hw-model` | yes | no
`/hw-serial-number` | string | command-line `--hw-serial-number` | yes | no
`/hw-manufacturer` | string | command-line `--hw-manufacturer` | yes | no
`/hw-mac` | string | command-line `--hw-mac` | no | no
`/hw-last-reboot-reason` | string | command-line `--hw-mac` | yes | no
`/fw-name` | string | command-line `--fw-name` | yes | no
`/boot-time` | number | command-line `--boot-time` | yes | no
`/local-url` | string | command-line `--parodus-local-url` | no | no
`/service-discovery-url` | string | command-line `--service-discovery-url` | no | no
`/last-reconnect-reason` | string | Determined internally.  Initially starts as `webpa_process_starts` and changes based on system conditions.  Not stored. | yes | no
`/protocol` | string | Provided by the program internally. | yes | no
`/fabric-url` | string | From the configuration file if available, or command-line `--webpa-url` if not available otherwise. | no | no
`/uuid` | string | From the configuration file if available or empty string otherwise. | no | no
`/ping-timeout` | number | command-line `--webpa-ping-timeout` | no | no
`/backoff-max` | number | command-line `--webpa-backoff-max` | no | no
`/inteface-used` | string | command-line `--webpa-interface-list=eth0,erouter0,brlan0` which is a list of interfaces to try, in order. | yes | no
`/tags/${name}` | string | Starts off initially as empty, populated via CRUD interface.  Stored in the configuration file each time values change or expire. | no | yes
`/tags/${name}/expires` | number | Same as `/tags/${name}` | no | yes

### Notes
The `backoff` count shall start at 2 so we have some gap between the tries.
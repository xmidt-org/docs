# Xmidt Documentation

This repository contains both the content and the static-site generator code for the
Xmidt documentation site.  The site can be found at https://xmidt.io

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Prerequisites](#prerequisites)
- [Build](#build)
- [Deploy](#deploy)
- [Contributing](#contributing)

## Code of Conduct

This project and everyone participating in it are governed by the [XMiDT Code Of Conduct](https://xmidt.io/code_of_conduct/).
By participating, you agree to this Code.

## Prerequisites

You need to have a working Ruby environment set up (including [bundler](https://bundler.io/))
and then install the necessary gems:

```bash
cd docs
make bundle
```

## Build

To generate the static site, run:

```bash
make build
```

The resulting static site will be stored in the `output` directory.

Optionally, you can use an API token to avoid rate limits on the API. You can get an API token from https://github.com/settings/tokens/new.
```bash
export GITHUB_AUTHENTICATION='-u user:token'

For building the codex swagger docs run
```bash
redoc-cli  bundle -o swagger.html --title "Codex Documentation" codex.yaml
```
```markdown
# then add the following to the top of the file
---
title: Swagger
sort_rank: 15
---
```

## Deploy

### Local Development Server

To run a local server that displays the generated site, run:

```bash
# Rebuild the site whenever relevant files change:
make guard
# Start the local development server in a separate shell:
make serve
```

You should now be able to view the generated site at
[http://localhost:3000/](http://localhost:3000).

### Automatic Production Deployment

Pull requests should contain the newly built site, in the `docs/` folder.  When
changes to the `docs/` folder are committed to master, the site automatically
gets redeployed.

## Contributing

See [`CONTRIBUTING.md`](CONTRIBUTING.md) for general instructions for new Xmidt contributors.

The main documentation contents of this website are located in the [`content/docs`](content/docs) directory.

Documentation concerning the various Xmidt/Codex/Webpa servers is cloned into the website at build time.

As a guideline, please keep the documentation generally applicable and avoid use-case-specific changes.

# ReScript React Kratos UI

A SPA (single page application) implementation of the browser-based flows for
[Kratos.](https://github.com/ory/kratos) Currently, the UI implements the login,
logout, registration, and recovery flows.

## Overview

This UI uses the browser flows to implement secure authentication flows. Browser
flows require an initial backend request that results in a redirect to the requesting
url with an authentication session token attached. The redirect may result in a
slight flicker, although running locally it's often too fast to notice.

Recently Kratos added support for [ajax flows](https://github.com/ory/kratos/pull/1367)
that don't require full page reloads that work poorly with SPAs.

## Tour

### Login
`/login`
![login](docs/img/login.png)

### Registration
`/register`
![login](docs/img/register.png)

### Recovery
`/recovery`
![login](docs/img/recovery.png)

### Landing
`/`
![login](docs/img/landing.png)

### Try it yourself

```sh
# Start backends to run UI against. This includes:
#   * Kratos
#   * Postgres - datastore for Kratos data
#   * Mailslurper - a test email server for routing recovery emails
#
# Optionally add `-d` flag in order to detach and run in the background.
docker-compose -f kratos/docker-compose-backends.yaml up --build --force-recreate

# Terminal 1 start ReScript compiler file watcher
npm run re:start

# Terminal 2 start parcel to bundle and serve UI
npm run serve
```

## Not Implemented

* Admin UI for managing Kratos assets.
* Account management pages for user self-serve account updates.

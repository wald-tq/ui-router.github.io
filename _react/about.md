---
title: "UI-Router for React"
layout: single
excerpt: "State based routing for React"
sitemap: true
permalink: /react/
---
{% include toc icon="columns" title="React" %}

<center>
<img src="/images/logos/react.png">
</center>

UI-Router provides extremely flexible, state based routing to the React ecosystem.

## Getting UI-Router

The UI-Router package is distributed using [npm](https://www.npmjs.com/), the node package manager.

```
npm install --save ui-router-react
```

## Tutorials

Learn UI-Router by following our tutorials.

- [Hello World](/tutorial/react/helloworld)
- [Hello Solar System](/tutorial/react/hellosolarsystem)
- [Hello Galaxy](/tutorial/react/hellogalaxy)
 
## Development

To fix a UI-Router bug, or create an enhancement, follow these steps: 

The Typescript source code for UI-Router for React can be found at https://github.com/ui-router/react
The react code depends on the UI-Router Core code, found at https://github.com/angular-ui/ui-router

To get started you will need to clone the UI-Router Core and UI-Router React repositories.

```
git clone https://github.com/angular-ui/ui-router
git clone https://github.com/ui-router/react
```

Then, you will need to build ui-router core and link it locally using `npm link`

```
cd ui-router
npm install
npm test
./scripts/package.sh core
cd build_packages/core
npm link
```

Then, link to it from the ui-router-react repository

```
cd ../../../react
npm install
npm link ui-router-core
```

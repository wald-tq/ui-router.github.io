---
title: "UI-Router for Angular 2"
layout: single
excerpt: "State based routing for Angular 2"
sitemap: true
permalink: /ng2/
---
{% include toc icon="columns" title="Angular 2" %}

<center>
<img src="/images/logos/angular2.png">
</center>

UI-Router provides extremely flexible, state based routing to the Angular 2 ecosystem.

## Getting UI-Router

The UI-Router package is distributed using [npm](https://www.npmjs.com/), the node package manager.

```
npm install --save ui-router-ng2
```

Other examples:

- Adding a specific version to your project: `npm install --save ui-router-ng2@1.0.0-beta.1`
- From <http://npmcdn.com> via a `<script>` tag in your html: 
  - Latest stable version: `<script src="//npmcdn.com/ui-router-ng2/_bundles/ui-router-ng2.js">`
  - A specific version: `<script src="//npmcdn.com/ui-router-ng2@1.0.0-beta.1/_bundles/ui-router-ng2.js">`

## Tutorials

Learn UI-Router by following our tutorials.

- [Hello World](/tutorial/ng2/helloworld)
- [Hello Solar System](/tutorial/ng2/hellosolarsystem)
- [Hello Galaxy](/tutorial/ng2/hellogalaxy)
 
## Development

To fix a UI-Router bug, or create an enhancement, follow these steps: 

The Typescript source code for UI-Router for Angular 2 can be found in <https://github.com/angular-ui/ui-router>
Note: This repository also hosts the code for UI-Router Core and UI-Router for Angular 1. 

To get started:

```
git clone https://github.com/angular-ui/ui-router
cd ui-router
npm install
npm test
```

All the code inside `src/` is relevant to angular 2, except for `ng1/`.
Most of the UI-Router test harness is written in Angular 1.

To create a UI-Router bundle to test a bug fix against your app, build it with the `package.sh` script.

```
./scripts/package.sh ng2
```

A npm package directory structure will be built in `build_packages/ng2`.
You can run `npm link` inside that directory, and then run `npm link ui-router-ng2` in your app's directory.
Your app's npm dependency will use the local `ui-router-ng2` package that you just built. 

Alternatively, bundles are also created in `build_packages/ng1/release/ui-router-ng2.js`.


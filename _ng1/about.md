---
title: "UI-Router for Angular 1"
layout: single
excerpt: "The defacto standard for routing in AngularJS"
sitemap: true
permalink: /ng1/
---
{% include toc icon="columns" title="Angular 1" %}

<center>
<img src="/images/logos/angular1.png">
</center>

## About 

UI-Router is the defacto standard for routing in AngularJS.
Influenced by the core angular router `$route` and the Ember Router, 
UI-Router has become the standard choice for routing non-trivial apps in Angular 1.

## Getting UI-Router

The UI-Router package is distributed using [npm](https://www.npmjs.com/), the node package manager.

```
npm install --save angular-ui-router
```

Other examples:

- Via command line
  - Adding the latest prerelease to your project: `npm install --save angular-ui-router@next`
  - Adding a specific version to your project: `npm install --save angular-ui-router@1.0.0-beta.1`
  
- From http://npmcdn.com via a `<script>` tag in your html: 
  - Latest stable version: `<script src="//npmcdn.com/angular-ui-router/release/angular-ui-router.min.js">`
  - A specific version: `<script src="//npmcdn.com/angular-ui-router@0.3.1/release/angular-ui-router.js">`
  
- From bower: `bower install angular-ui-router#0.3.1`

Note: bower releases are considered 'legacy' and are managed at https://github.com/angular-ui/angular-ui-router-bower
  
## Tutorials

Learn UI-Router by following our tutorials.

- [Hello World](/tutorial/ng1/helloworld)
- [Hello Solar System](/tutorial/ng1/hellosolarsystem)
- [Hello Galaxy](/tutorial/ng1/hellogalaxy)
 
## Development

To fix a UI-Router bug, or create an enhancement, follow these steps: 

The Typescript source code for UI-Router for Angular 1 can be found in https://github.com/angular-ui/ui-router
Note: This repository also hosts the code for UI-Router Core, and UI-Router for Angular 2. 

To get started:

```
git clone https://github.com/angular-ui/ui-router
cd ui-router
npm install
npm test
```

All the code inside `src/` is relevant to angular 1, except for `justjs.js` and `ng2/`.
Most of the UI-Router test harness is also written in Angular 1.

To create a UI-Router bundle to test a bug fix against your app, build it with the `package.sh` script.

```
./scripts/package.sh ng1
```

A npm package directory structure will be built in `build_packages/ng1`.
You can run `npm link` inside that directory, and then run `npm link angular-ui-router` in your app's directory.
Your app's npm dependency will use the local `angular-ui-router` package that you just built. 

Alternatively, bundles are also created in `build_packages/ng1/release/angular-ui-router.js`.



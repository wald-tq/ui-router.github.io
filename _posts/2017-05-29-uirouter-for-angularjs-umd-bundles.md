---
layout: post
excerpt: UMD Bundles and UI-Router 1.0 for AngularJS
comments: true
permalink: /blog/:title/
---

This post describes how UMD bundles have changed with UI-Router 1.0 for AngularJS.

### UI-Router Core

The `angular-ui-router` has been the defacto standard for routing in AngularJS.
However, over the years UI-Router has undergone some significant transformations.

The core of the library has been refactored into its [own library, `@uirouter/core`](https://github.com/ui-router/core).
This core library has been used to create new routers for 
[React](https://github.com/ui-router/react), 
[It's Just Angular (2.x+)](https://github.com/ui-router/angular), 
[Polymer](https://github.com/ergo/polymer-ui-router), and even 
[Backbone/Marionette](https://github.com/bobmanary/ui-router-marionette).


### Plugins and UMD bundles

When UI-Router for AngularJS 1.0 was released, we split the bundles into `ui-router-core.js` and `ui-router-angularjs.js`.
This was necessary to support plugins which depend only on the framework-agnostic `ui-router-core.js`.
Note: we also [renamed our NPM packages to scoped package names](/blog/uirouter-scoped-packages/).

Users who formerly included only `angular-ui-router.js` should now include both bundles.
Add [`ui-router-core.js`](https://unpkg.com/@uirouter/core/_bundles/) from the [`@uirouter/core` package](https://github.com/ui-router/core)
as well as [`ui-router-angularjs.js`](https://unpkg.com/@uirouter/angularjs@1.0.3/release/) from the [`@uirouter/angularjs` package](https://github.com/angular-ui/ui-router).

### Backwards compatibility mono-bundle

For backwards compatibility reasons, we will continue to publish a monolithic bundle as [`angular-ui-router.js`](https://unpkg.com/@uirouter/angularjs/release/).
This bundle includes *both the core and angularjs code*.
However, this bundle is not compatible with many UI-Router plugins which depend on `@uirouter/core`.

### Webpack users

Users of webpack (or any bundlers which use node module resolution) should not need to make any changes because of UMD bundles.
Simply `require` or `import` from the [scoped package](/blog/uirouter-scoped-packages/) `@uirouter/angularjs` instead of from `angular-ui-router`.

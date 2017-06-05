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

Previously, UI-Router was a single bundle: `angular-ui-router.js`.

During the UI-Router for AngularJS 1.0 release, we split the code into two bundles:

- `ui-router-core.js`: the core of UI-Router (State machine, etc)
- `ui-router-angularjs.js`: the AngularJS bits (`$location`, `ui-sref` directives, etc)

*Users who formerly included only `angular-ui-router.js` should now include both bundles.*

This change was necessary to properly support dependencies to `@uirouter/core`.
This enables (for example) router plugins which work with the framework-agnostic `ui-router-core.js`.

Note: we also [renamed our NPM packages to scoped package names](/blog/uirouter-scoped-packages/).
{: .notice--info }

### Migration

If you _formerly_ used `angular-ui-router.js`, e.g.:
```js
<script src="node_modules/angular-ui-router/release/angular-ui-router.js"></script>
```js

Instead, *use both new bundles from the scoped packages*.
Include `ui-router-core` before including `ui-router-angularjs`:
```js
<script src="node_modules/@uirouter/core/_bundles/ui-router-core.js"></script>
<script src="node_modules/@uirouter/angularjs/release/ui-router-angularjs.js"></script>
```js

{: .notice--info }
Ensure the version of `@uirouter/core` matches [the dependency](https://unpkg.com/@uirouter/angularjs/package.json) in `@uirouter/angularjs`.

### Backward compatible mono-bundle

For backwards compatibility, we will continue to publish a monolithic bundle as [`angular-ui-router.js`](https://unpkg.com/@uirouter/angularjs/release/).
This bundle includes *both the core and angularjs code*.
Existing users who rely on the `angular-ui-router.js` bundle _do not have to change anything_.
However, this bundle is not compatible with UI-Router plugins which depend on `@uirouter/core`.

### Webpack users

Users of webpack (or any bundlers which use node module resolution) should not need to make any changes due to these bundle changes.
Simply `require` or `import` from the [scoped package](/blog/uirouter-scoped-packages/) `@uirouter/angularjs` instead of from `angular-ui-router`.

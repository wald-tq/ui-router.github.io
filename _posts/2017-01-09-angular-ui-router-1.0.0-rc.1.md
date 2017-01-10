---
layout: post
excerpt: UI-Router 1.0.0-rc.1 is released
comments: true
permalink: /blog/:title/
redirect_from: /blog/uirouter-1.0.0-rc.1/
---

{% include toc icon="columns" title="UI-Router 1.0.0-rc.1" %}

We released Angular UI-Router 1.0.0-rc.1 today.
This release indicates that the APIs are not expected to change before the final release of ui-router 1.0.

This release includes more breaking changes than usual.
We are making an effort to call out more breaking changes that could potentially break end user applications, even if the prior behavior was unspecified.

## Changes in RC.1

RC.1 is a major update, which includes many bug fixes and lots of new features.

Please see the [release notes](https://github.com/angular-ui/ui-router/releases/tag/1.0.0-rc.1) for detailed information, including the breaking changes.


## Repository split

During the 1.0 alpha phase, we made the UI-Router core agnostic to Angular 1.
This enabled us to create 
[`ui-router-ng2`](https://ui-router.github.io/ng2/) and 
[`ui-router-react`](https://ui-router.github.io/react/) 
by augmenting the 
[`ui-router-core`](https://github.com/ui-router/core) 
code.

During the betas, both `ui-router-ng2` and the `angular-ui-router` for ng1 code were built from the same repository.
This seemed like a good idea at the time because it allowed PRs to a monolithic repository.
However, over time it became apparent that hosting both codebases together was not sustainable.
So, we split the repositories into:

- http://github.com/angular-ui/ui-router: `angular-ui-router`: UI-Router for AngularJS 1
- http://github.com/ui-router/ng2: `ui-router-ng2`: UI-Router for Angular (2.0 and above)
- http://github.com/ui-router/core: `ui-router-core`: UI-Router core

This release is the first one built from the modular UI-Router repositories.

This release (1.0.0-rc.1) of Angular UI-Router is *not accompanied by a release of UI-Router for Angular 2+*.
Going forward, the release schedules for Angular 1 and Angular 2 will no longer coincide.


#### Upgrading

If you haven't considered upgrading to UI-Router 1.0, now is the time to start planning.
There are some breaking changes listed, but the should be fairly minimal for the typical UI-Router application.
Please follow the [migration guide](https://ui-router.github.io/guide/ng1/migrate-to-1_0) when upgrading.



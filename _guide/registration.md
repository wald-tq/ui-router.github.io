---
title: "State Registration"
layout: single
excerpt: "Add application states to the state registry"

sitemap: true
---
{% include toc icon="columns" title="Registration" %}

# Registering states

As we've learned, your application states are registered with the `$stateProvider`.

## Use a `.config()` block

We generally want to register our states *before the application bootstraps*.  In Angular, the 
[`.config()` block](https://docs.angularjs.org/guide/module#configuration-blocks) 
is used to perform pre-bootstrap configuration.  

When the app bootstraps, UI-Router will activate the state that matches the current URL.  
If your states are not registered by this time, the user will be sent to your `otherwise()` route, instead
of to the state they have bookmarked.
{: .notice--warning}

<!-- update this to reference $stateRegistry? -->

It is possible to register states *after* bootstrap is complete.  You just need to hang on to a copy of the 
`$stateProvider` yourself.  You may also find `$urlRouterProvider.deferIntercept()` useful.
{: .notice--info}

## Two ways to specify `name`

The `$stateProvider.state()` registration function has two different overloads.  

1. You can pass it a state definition, which has a `name:` property

   ```js
   $stateProvider.state({ name: 'foo', url: '/foo', template: '<h1>FOO</h1>' });
   ```

2. You can also pass the name as the first argument, and the rest of the state definition (without a `name:` property)
   as the second argument.

   ```js
   $stateProvider.state('foo', { url: '/foo', template: '<h1>FOO</h1>' });
   ```

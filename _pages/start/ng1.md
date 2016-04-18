---
title: "Getting started: Angular 1"
layout: single
excerpt: "Getting started with UI-Router for Angular 1"
sitemap: true
permalink: /start/ng1
---

1. Get UI-Router for Angular 1 using your preferred mechanism:
  - Using npm: `npm install angular-ui-router`
  - Using bower: `bower install angular-ui-router`
  - Download directly from [npmcdn](https://npmcdn.com/angular-ui-router@0.2.18/release/angular-ui-router.js)

2. Add the `angular-ui-router.js` script tag after `angular.js`

```html
<head>
  <script src="lib/angular.js"></script>
  <script src="lib/angular-ui-router.js"></script>
</head>
```

3. Create a module dependency on the `ui.router` angular module

```js
var myApp = angular.module('myApp', ['ui.router']);
```

4. Create two top-level states using the `$stateProvider`

```js
myApp.config(function($stateProvider) {

  $stateProvider.state('hello', {
    url: '/hello',
    template: '<h3>hello world!</h3>'
  });
  
  $stateProvider.state('about', {
    url: '/about',
    template: '<h3>Its the UI-Router hello world app!</h3>'
  });
  
});
```

5. Add a `<ui-view>` tag (ui-router viewport) to your HTML.  When your states are activated, they 
will fill in this viewport.

```html
<body ng-app="myApp">
  <ui-view></ui-view>
</body>
```

6. Add some `ui-sref` links, which can be used to activate your states.

```html
<body>
  <a ui-sref="hello">Hello</a>
  <a ui-sref="about">About</a>
  <ui-view></ui-view>
</body>
```

### The whole thing

Here is a live plunker [(edit)](http://plnkr.co/edit/6eQV15?p=preview):

<iframe style="width: 100%; height: 600px" src="http://embed.plnkr.co/6eQV15/" frameborder="0" allowfullscren="allowfullscren"></iframe>


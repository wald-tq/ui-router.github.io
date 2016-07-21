---
title: "Hello World!"
layout: single
excerpt: "Getting started with UI-Router for Angular 2"
sitemap: true
---
{% include toc icon="columns" title="Hello World!" %}

Let's build a Hello World UI-Router application for Angular 2.
It will have two "pages" (`hello` and `about`), each one having its own URL.
We can switch between pages by clicking on links.
The link for the active page will be highlighted.

# Full Source Code

An Angular 2 Hello World app is a bit more complex to set up than an Angular 1 or React Hello World App.
We're going to use the [Angular 2 Plunker template](http://plnkr.co/edit/tpl:AvJOMERrnz94ekVua0u5) as starting point.

Start by looking over the complete source code (ignoring SystemJS `config.js`) for the Hello World application.
We will go over each part in more detail below.

## `index.html`

```html
<html>
  <head>
    <script src="https://npmcdn.com/zone.js@0.6.12/dist/zone.js"></script>
    <script src="https://npmcdn.com/reflect-metadata@0.1.3/Reflect.js"></script>
    <script src="https://npmcdn.com/systemjs@0.19.31/dist/system.js"></script>
    <script src="https://npmcdn.com/typescript@1.8.10/lib/typescript.js"></script>
    <script src="config.js"></script>
    <script>
      System.import('helloworld').catch(console.error.bind(console)); 
    </script>
    
    <style>.active { color: red; font-weight: bold; }</style>
  </head>

  <body>
    <my-app>
      Loading...
    </my-app>
  </body>

</html>
```

## `helloworld.js`

{% raw %}
```js
/** imports */

import {bootstrap} from '@angular/platform-browser-dynamic';
import {LocationStrategy, HashLocationStrategy} from "@angular/common";
import {Component} from '@angular/core';
import {
  UIROUTER_PROVIDERS, UIROUTER_DIRECTIVES, 
  UIRouter, UIView, UIRouterConfig
} from "ui-router-ng2";

/** Components */

@Component({
  selector: 'my-app',
  directives: [UIROUTER_DIRECTIVES]
  template: `
  <a uiSref="hello" uiSrefActive="active">Hello</a>
  <a uiSref="about" uiSrefActive="active">About</a>
  
  <ui-view></ui-view>
  `
})
export class App { }

@Component({  
  template: '<h3>Hello world!</h3>' 
})
class Hello { }

@Component({ 
  template: '<h3>Its the UI-Router hello world app!</h3>' 
})
class About { }


/** States */

let helloState = { name: 'hello', url: '/hello',  component: Hello }; 
let aboutState = { name: 'about', url: '/about',  component: About };

/** UIRouter Config */

class MyUIRouterConfig {
  configure(router: UIRouter) {
    router.stateRegistry.register(helloState));
    router.stateRegistry.register(aboutState));
  }
}

/** Angular 2 bootstrap */

bootstrap(App, [
    ...UIROUTER_PROVIDERS,
    {  provide: UIRouterConfig, useClass: MyUIRouterConfig  },
    {  provide: LocationStrategy, useClass: HashLocationStrategy }
]).catch(err => console.error(err));
```
{% endraw %}

# Live demo

A live demo of the finished app can be seen below, in the [Plunker](https://plnkr.co/).  Navigate between the
"Hello" and "About" links and watch the UI change.

<iframe class="plunker" style="height: 350px" 
  src="//embed.plnkr.co/emMpITE71x5kYrXmZ5Vw/?show=preview" 
  frameborder="1" allowfullscren="allowfullsceen"></iframe>
<br>

# Prepping Hello World

Follow these steps to make your own copy of the Hello World app.

## Get UI-Router

Get the UI-Router for Angular 2 code using npm

```
npm install angular-ui-router
```

You could alternatively refer to the 
[copy distributed on npmcdn.com](https://npmcdn.com/ui-router-ng2@latest/_bundles/ui-router-ng2.js).
(This is how the live demo plunkers function)

## Configure your module loader

Angular 2 development requires a module loader and is best with a bundler, such as webpack.
There are many benefits to bundling, but one critical benefit for Angular 2 is tree shaking capabilities, which eliminates unused code from the bundle.

For these tutorials, however, we're going to use SystemJS and the full UMD bundles.
First, create an empty `helloworld.js` file.

**SystemJS config.js**

The `map` section of `config.js` tells the System loader where to look for things.
Add an entry for `ui-router-ng2` in the `map:` section.
This entry must allow us to `import from 'ui-router-ng2'` and get the `ui-router-ng2` library entry point  (`main:` from `package.json`).

Add a second second entry for `helloworld` which will get us the helloworld app entry point.

```js
...
  map: {
    '@angular': 'https://npmcdn.com/@angular',
    'rxjs': 'https://npmcdn.com/rxjs@5.0.0-beta.6',
    'ui-router-ng2': 'https://npmcdn.com/ui-router-ng2@1.0.0-beta.1/_bundles/ui-router-ng2',
    helloworld: "./helloworld.ts"
  },
...
```

SystemJS is a large, nuanced topic, but this is as far as we're going to discuss for this tutorial.

## Script tags

The scripts loaded from npmcdn are prerequisites for Angular2 + Typescript running in a plunker.

The `config.js` script is our SystemJS configuration.

```html
  <head>
    <script src="https://npmcdn.com/zone.js@0.6.12/dist/zone.js"></script>
    <script src="https://npmcdn.com/reflect-metadata@0.1.3/Reflect.js"></script>
    <script src="https://npmcdn.com/systemjs@0.19.31/dist/system.js"></script>
    <script src="https://npmcdn.com/typescript@1.8.10/lib/typescript.js"></script>
    <script src="config.js"></script>
    ...
```

## Bootstrapping the javascript
This script tells the module loader to load `helloworld`, which is our application's entry point.

```html
    <script>
      System.import('helloworld').catch(console.error.bind(console)); 
    </script>
```

# Building Hello World

## ES6 imports

In order to access the code required to bootstrap Angular 2 and UI-Router, we need to import a bunch of things.

```js
import {bootstrap} from '@angular/platform-browser-dynamic';
import {LocationStrategy, HashLocationStrategy} from "@angular/common";
import {Component} from '@angular/core';
import {
  UIROUTER_PROVIDERS, UIROUTER_DIRECTIVES, 
  UIRouter, UIView, UIRouterConfig
} from "ui-router-ng2";
```

## Creating the components

Create the Angular 2 components that make up our application.

**The `hello` and `about` components**

Create two components for our two "pages".

```js
@Component({  
  template: '<h3>Hello world!</h3>' 
})
class Hello { }

@Component({ 
  template: '<h3>Its the UI-Router hello world app!</h3>' 
})
class About { }
```

These two simple components make up the two pages of our application.
One of these components will be shown, when its cooresponding state is active.

**The root component**

The `MyApp` component will be the root of the application component tree.
This is the component that we will bootstrap with Angular 2 as the root of our application.

```js
@Component({
  selector: 'my-app',
  directives: [UIROUTER_DIRECTIVES]
  template: `
  <a uiSref="hello" uiSrefActive="active">Hello</a>
  <a uiSref="about" uiSrefActive="active">About</a>
  
  <ui-view></ui-view>
  `
})
class MyApp { }
```

#### Viewport 

The MyApp component contains a `<ui-view>` viewport.
The `<ui-view>` viewport will be filled with the component from the currently active state.

#### Links

It also contains two anchor tags with `uiSref` directives.
The `uiSref` directives are links, similar to an anchor tag's `href.
Instead of linking to a URL like an `href`, a `uiSref` links to a state.
  
When clicked, the linked state is activated.
The `uiSref` directive automatically builds a `href` attribute for you (`<a href=...></a>`) based on your state's url.

#### Active Link

The `uiSref` links also have `uiSrefActive='active'`, which is another directive. 
The addition of `uiSrefActive='active'` adds the `active` css class to the link when the target state is active.

## Instantiating the root component

Inside the `<body>` tag, we add markup for our application's root Component.
Angular 2 applications are a tree of components and `<my-app>` is the root of that tree.

```html
  <body>
    <my-app>
      Loading...
    </my-app>
  </body>
```

## Create your first states

A state is the basic building block for UI-Router applications.
This javascript object is a simple state definition.

```js
let helloState = { name: 'hello', url: '/hello',  component: Hello }; 
```

This simple state definition has three properties:

`name`
:    The state is named `hello`.

`url`
:    When the state is active, the browser's url will be `/hello`.

`component`
:    The `component:` property value is the Angular 2 component class that will be loaded into the viewport when the state is active.  In this case, we will load the `Hello` component.

Add the other about state:

```js
let helloState = { name: 'hello', url: '/hello',  component: Hello }; 
let aboutState = { name: 'about', url: '/about',  component: About };
```

## Create the UIRouter configuration

The `UIRouterConfig` object is used to configure UIRouter when Angular 2 is bootstrapped.

```js
class MyUIRouterConfig {
  configure(router: UIRouter) {
    router.stateRegistry.register(helloState));
    router.stateRegistry.register(aboutState));
  }
}
```

This `UIRouterConfig`'s `.configure()` method receives the router instance.
It then registers the two states with the router's `stateRegistry`.

## Bootstrapping Angular 2

Bootstrap Angular 2 with the MyApp root component and our Angular 2 Providers.

```js
bootstrap(MyApp, [
    ...UIROUTER_PROVIDERS,
    {  provide: UIRouterConfig, useClass: MyUIRouterConfig  },
    {  provide: LocationStrategy, useClass: HashLocationStrategy }
]).catch(err => console.error(err));
```

We include `...UIROUTER_PROVIDERS` to add UI-Router to the Angular 2 application.
The `...` at the beginning is ES6 destructuring.

Second, with `{  provide: UIRouterConfig, useClass: MyUIRouterConfig  },` we tell Angular 2 to use `MyUIRouterConfig`
whenever UI-Router requests the `UIRouterConfig`.

Finally, we define the Angular 2 `LocationStrategy` to use, and set it to `HashLocationStrategy` (for plunker).
The other option is `PathLocationStrategy`, which uses HTML5 push state.

---

Go back to the [live demo](#live-demo) and check it out!

When you're finished, move on to the [Hello Solar System!](hellosolarsystem) tutorial.


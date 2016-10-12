---
title: "UI-Router for React - Hello World!"
excerpt: "Getting started with UI-Router for React"
layout: single
sitemap: true
---

{% include toc icon="columns" title="Hello World!" %}

Let's build a UI-Router for React Hello World application.
It will have two "pages" (`hello` and `about`), each one having its own URL.
We can switch between pages by clicking on links.
The link for the active page will be highlighted.

# Full Source Code

Start by looking over the complete source code (ignoring SystemJS `config.js`) for the Hello World application. We will go over each part in more detail below.

## `index.html`

```html
<html>

  <head>
    <script src="//unpkg.com/systemjs/dist/system.js"></script>
    <script src="systemjs.config.js"></script>
    <script>
      System.import("helloworld").catch(console.error.bind(console));
    </script>

    <style>.active { color: red; font-weight: bold }</style>
  </head>

  <body>
    <div id="react-app"></div>
  </body>

</html>
```

## `helloworld.jsx`

```javascript
import React from 'react';
import ReactDOM from 'react-dom';
import UIRouterReact, {UIView, UISref, UISrefActive} from 'ui-router-react';


const router = new UIRouterReact();

var helloState = {
  name: 'hello',
  url: '/hello',
  component: () => <h3>hello world</h3>
}

var aboutState = {
  name: 'about',
  url: '/about',
  component: () => <h3>Its the UI-Router hello world app!</h3>
}

router.stateRegistry.register(helloState);
router.stateRegistry.register(aboutState);

router.start();

ReactDOM.render(
  <div>
    <UISrefActive class="active">
      <UISref to="hello"><a>Hello</a></UISref>
    </UISrefActive>
    <UISrefActive class="active">
      <UISref to="about"><a>About</a></UISref>
    </UISrefActive>

    <UIView/>
  </div>,
  document.getElementById('react-app')
);
```

# Live demo

A live demo of the finished app can be seen below, in the [Plunker](https://plnkr.co/).  Navigate between the
"Hello" and "About" links and watch the UI change.

<iframe class="plunker" style="height: 350px"
  src="//embed.plnkr.co/V7WidRpNvgqHoCS7hHbl/?show=preview"
  frameborder="1" allowfullscren="allowfullsceen"></iframe>
<br>

# Prepping Hello World

Follow these steps to make your own copy of the Hello World app.

## Get UI-Router

Get the UI-Router for React code using npm

```
npm install ui-router-react
```

You could alternatively refer to the
[copy distributed on unpkg.com](https://unpkg.com/ui-router-react@latest/_bundles/ui-router-react.min.js).
(This is how the live demo plunkers function)

## Configure your module loader

React development requires a module loader and is best with a bundler, such as webpack.
There are many benefits to bundling, but one critical benefit for React is tree shaking capabilities, which eliminates unused code from the bundle.

For these tutorials, however, we're going to use SystemJS and the full UMD bundles.
First, create an empty `helloworld.jsx` file.

**SystemJS config.js**

The `map` section of `systemjs.config.js` tells the System loader where to look for things.
Add an entry for `ui-router-react` in the `map:` section.
This entry must allow us to `import from 'ui-router-react'` and get the `ui-router-router` library entry point  (`main:` from `package.json`).

Add a second second entry for `helloworld` which will get us the helloworld app entry point.

```js
...
  map: {
    "react": "//unpkg.com/react@15/dist/react.js",
    "react-dom": "//unpkg.com/react-dom/dist/react-dom.js",
    "ui-router-react": "//unpkg.com/ui-router-react@latest/_bundles/ui-router-react.js",
    "helloworld": "./"
  },
  packages: {
    helloworld: {
    main: './helloworld.js',
    defaultExtension: 'js'
    }
  }
...
```

SystemJS is a large, nuanced topic, but this is as far as we're going to discuss for this tutorial.

## Script tags

The scripts loaded from npmcdn are prerequisites for React + JSX running in a plunker.

The `config.js` script is our SystemJS configuration.

~~~html
  <head>
    ...
    <script src="//unpkg.com/systemjs/dist/system.js"></script>
    <script src="systemjs.config.js"></script>
    ...
~~~

## Bootstrapping the javascript
This script tells the module loader to load `helloworld`, which is our application's entry point.

```html
    <script>
      System.import('helloworld').catch(console.error.bind(console));
    </script>
```

# Building Hello World

## ES6 imports

In order to access the code required to bootstrap React and UI-Router, we need to import a bunch of things.

```js
import React from 'react';
import ReactDOM from 'react-dom';
import UIRouterReact, {UIView, UISref, UISrefActive} from 'ui-router-react';
```

## Creating the components

Create the React components that make up our application.

**The `Hello` and `About` components**

Create two components for our two "pages".

~~~js
const Hello = () => <h3>hello world</h3>;
const About = () => <h3>Its the UI-Router hello world app!</h3>
~~~

These two stateless components make up the two pages of our application.
One of these components will be shown, when its corresponding state is active.

*Viewport*

The application contains a `<UIView>` viewport.
The `<UIVIew>` viewport will be filled with the component from the currently active state.

*Links*

It also contains two anchor tags wrapped into `UISref` components.
The `UISref` components create a link and attach it to their child elements, similar to an anchor tag's `href`.
Instead of linking to a URL like an `href`, a `UISref` links to a state.

When clicked, the linked state is activated.
The `UISref` component automatically builds a `href` attribute for you (`<a href=...></a>`) based on your state's url.

*Active Link*

The `UISref` components are also wrapped by a `<UISrefActive class="active">`, which is another component.
The addition of `UISrefActive` adds the `active` css class to the `UISref`'s child when the target state is active.

## Instantiating the root component

Inside the `<body>` tag, we add markup for our application's components.

```html
  <body>
    <div id="react-app">
    Loading...
    </div>
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
:    The `component:` property value is the React component class that will be loaded into the viewport when the state is active.  In this case, we will load the `Hello` component.

Add the other about state:

```js
let helloState = { name: 'hello', url: '/hello',  component: Hello };
let aboutState = { name: 'about', url: '/about',  component: About };
```

## Configure and start UIRouter

We can create a new instance of the router and configure it with our states.

```js
const router = new UIRouterReact();

router.stateRegistry.register(helloState);
router.stateRegistry.register(aboutState);

router.start();
```

The `.stateRegistry.register()` method takes care of registering our states.
The `.start()` method tells the Router to activate, listen for url changes and handle view changes.

## Bootstrapping React

Bootstrap React.

```js
ReactDOM.render(
  <div>
    <UISrefActive class="active">
      <UISref to="hello"><a>Hello</a></UISref>
    </UISrefActive>{' '}
    <UISrefActive class="active">
      <UISref to="about"><a>About</a></UISref>
    </UISrefActive>

    <UIView/>
  </div>,
  document.getElementById('react-app')
);
```

---

Go back to the [live demo](#live-demo) and check it out!

When you're finished, move on to the [Hello Solar System!](hellosolarsystem) tutorial.


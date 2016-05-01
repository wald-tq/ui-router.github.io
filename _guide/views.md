---
title: "Views"
layout: single
excerpt: "UI-Router view definitions"

sitemap: true
---
{% include toc icon="columns" title="Views" %}

A view provides the UI and UI behavior for a state.  A state's view consists of a template, and the logic to control it.
The view is plugged into the matching `<ui-view>` viewport directive.  

Note: `ui-view` can either be an element (as we've seen it so far), or an attribute of some 
other element, such as `<div ui-view></div>`
{: .notice--info}

# Defining views

UI-Router for Angular 1 offers a variety of options for defining a view.

## Angular 1.5+ `.component()`

We encourage developers to use [Angular 1.5+ components](https://docs.angularjs.org/guide/component).
A component pairs a controller and template together as a single unit with well defined inputs.  

Create a component for your state using the Angular 1.5 `.component()` method.  This component should 
implement the desired UI look and behavior for the view.

```js
var fooTemplate = "<ul><li ng-repeat="foo in $ctrl.fooData">{{foo.name}}</li></ul>";
myApp.component('fooComponent', {
  template: fooTemplate,
  controller: function() { },
  bindings: { 
    fooData: '<'
  }
});
```

In the state definition, set the `component:` property to the name of your component.

```js
var fooState = {
  name: 'foo',
  url: '/foo',
  component: 'fooComponent',
  resolve: {
    fooData: (FooService) => FooService.list()
  }
}
```

UI-Router finds the correct `<ui-view>` viewport and puts the `fooComponent` in it.

We will learn more about `bindings` and `resolve` in the [Resolve Section](/tutorial/resolve).
{: .notice--info}

### Template+Controller

UI-Router works best using components, and we *highly recommend you use them*.

However, you can also pair templates and controllers without using a `component`.  Set 
the `template:` and `controller:` properties on the state definition.

```js
var fooTemplate = "<ul><li ng-repeat="foo in $ctrl.fooData">{{foo.name}}</li></ul>";
var fooState = {
  name: 'foo',
  url: '/foo',
  template: fooTemplate,
  controller: function(fooData) {
    this.fooData = fooData;
  },
  controllerAs: '$ctrl',
  resolve: {
    fooData: (FooService) => FooService.list()
  }
}
```

UI-Router finds the `<ui-view>` and puts the template+controller combination in it.  

Although we used an inline `template:` here, you can instead specify `templateUrl: "/path/to/template.html"`
to use an external template.
{: .notice--info}

Although we used an inline controller here, you can instead specify `controller: 'FooController'` to use a 
named controller that you've registered elsewhere.
{: .notice--info}

When using template+controller you can specify `controllerAs` to alias the controller object in your templates.
[Read more about controllerAs](https://toddmotto.com/digging-into-angulars-controller-as-syntax/)
{: .notice--info}



# Multiple named views

Up until now, we've defined a single view per state.  Those views filled in the *unnamed viewport* (`<ui-view>`).  
However, UI-Router allows *multiple views* for a single state.    This can be useful to define a layout with
named sections.  For instance, you may want a layout with a header, navigation and content.

```
+-------------------------------------------+
|               HEADER                      |
|------+------------------------------------|
|      |                                    |
|      |                                    |
| NAV  |        CONTENT                     |
|      |                                    |
|      |                                    |
+------+------------------------------------+
```

## Named Views

To use multiple views, we give each view a name.  Instead of defining a single `component:` property on the 
state, we instead create a `views:` object on the state definition.  The object's keys are the names of the views, and
the values are the component names.

```js
var mainState = {
  name: 'main',
  views: {
    header: 'headerComponent',
    nav: 'navComponent',
    content: 'mainComponent',
  }
}
```

## Targeting a named `ui-view`

Those named views then target a `ui-view` with the matching name.

```html
<ui-view name="header"></ui-view>
<ui-view name="nav"></ui-view>
<div ui-view="content"></div>
```

When the `main` state is activated:

- Its `header` view fills the `<ui-view name="header"></ui-view>`
- Its `nav` view fills the `<ui-view name="nav"></ui-view>`
- Its `content` view fills the `<div ui-view="content"></div>`


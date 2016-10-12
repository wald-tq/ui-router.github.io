---
title: "UI-Router for Angular 1 - Hello Solar System!"
excerpt: "Learn about components, resolve data, and parameters"
---
{% include toc icon="columns" title="Hello Solar System!" %}

In this tutorial, we will build on [Hello World!](helloworld) and create a slightly more ambitious _Hello Solar System_ app.

We will implement a [list/detail interface](https://en.wikipedia.org/wiki/Master%E2%80%93detail_interface), 
also known as master-detail.
To accomplish this, we will create two new application states:

- The `people` state will show a list of all the people.
- The `person` state will show details for a specific person.

Additionally, we will switch our views from templates to Angular 1.5 components.

At any time, the user can click "reload plunker", and the app will restart at the same URL.
The URL contains the information necessary to restore the application's state.
When the app is restarted, it will be in the same state as before.
{: .notice--info}

Plunker embeds can time out.
If you get a "Not Found" response, your plunker embed has timed out.
Click the "Refresh" icon to get a new plunker, then try experimenting with the "reload plunker" button again.
{: .notice--info}

## Live demo

Take a look at the completed Hello Solar System live demo below.
Click the `ui-sref` labeled "People" to view the list of all people.
Click a person to view the person details.

As you navigate through the app, the [UI-Router State Visualizer](https://github.com/ui-router/visualizer) shows
the current state
{: .notice--info}

<iframe style="width: 100%; height: 350px;" src="//embed.plnkr.co/2SSO4Y/?show=preview" frameborder="1" allowfullscren="allowfullscren"></iframe>

<br>

# New concepts

This app introduces some new concepts and UI-Router features.

- [Route to component](#route-to-component)
- [Resolve data](#resolve-data)
- [State Parameters](#state-parameters)
- [Linking with params](#linking-with-params)

## Route to component

Although UI-Router allows you to define your views using arbitrary `template` and `controller` combinations, we
recommend instead that you adopt a component based architecture.

Angular 1.5 introduced the `.component()`, which is a special class of directives.
A component encapsulates a template and a controller as a single unit, and also explicitly defines its
inputs (data) and outputs (events).
To learn more, read the official [Angular 1.5+ component docs](https://docs.angularjs.org/guide/component),
and explore a [blog](https://toddmotto.com/exploring-the-angular-1-5-component-method) or two.

---

To route to a component that you have created, add a `component: 'myComponentName'`
property on your state definition (and do not use `template:` or `controller:` properties).

The Hello Solar System `hello` component:

{% raw %}
```js
angular.module('hellogalaxy').component('hello', {
  template:  '<h3>{{$ctrl.greeting}} Solar System!</h3>' +
             '<button ng-click="$ctrl.toggleGreeting()">toggle greeting</button>',
           
  controller: function() {
    this.greeting = 'hello';
  
    this.toggleGreeting = function() {
      this.greeting = (this.greeting == 'hello') ? 'whats up' : 'hello'
    }
  }
})
```
{% endraw %}

... and the Hello Solar System `hello` state definition:

```js
var helloGalaxy = {
  name: 'hello',
  url: '/hello',
  component: 'hello'
}
```

The string `'hello'` in `component: 'hello'` is used to reference the component 
that you registered with angular, i.e., `.component('hello', ...)`
{: .notice--info}

## Resolve data

When a user switches back and forth between states of a single page web 
app, the app often needs to fetch application data from a server API, 
such as a REST endpoint.

A state can specify the data it requires by using a `resolve:` block.
When the user tries to activate a state which has a `resolve:` block,
UI-Router will fetch the required data *before activating the state*.

An Angular 1 `resolve:` block is an object on a state definition.
Each key is the name of some data to load, and each value is a function which returns a promise for the data.  
Resolve functions are injected using Angular's injector.
{: .notice--info}

The Hello Solar System `people` state has a resolve block:

```js
var peopleState = {
  name: 'people',
  url: '/people',
  component: 'people',
  resolve: {
    people: function(PeopleService) {
      return PeopleService.getAllPeople();
    }
  }
},
```

When fetching data, we recommend delegating to services which return promises.
{: .notice--info}

After the data has been fetched, it is mapped to the component's input `bindings:` by name.
The Hello Solar System `people` component has a `bindings:` with an input `people` that matches the resolve's name:

{% raw %}
```js
angular.module('hellogalaxy').component('people', {
  bindings: { people: '<' },

  template: '<h3>Some people:</h3>' +
            '<ul>' +
            '  <li ng-repeat="person in $ctrl.people">' +
            '    <a ui-sref="person({ personId: person.id })">' +
            '      {{person.name}}' +
            '    </a>' +
            '  </li>' +
            '</ul>'
})
```
{% endraw %}

UI-Router waits until the promise returned from `PeopleService.getAllPeople()` resolves before activating the `people` state.
Then, it feeds the list of people into the `people` component's `people:` binding.
It inserts the `people` component into the `<ui-view>` viewport.

## State Parameters

We also want to allow the user to be able view the details for a specific person.
The `person` state takes a `personId` parameter, and uses it to fetch that specific person's details.

The parameter value is included as a part of the URL.
This enables the same person details to be shown when the plunker is reloaded.

The `person` state definition:

```js
{
  name: 'person',
  url: '/people/{personId}',
  component: 'person',
  resolve: {
    person: function(PeopleService, $transition$) {
      return PeopleService.getPerson($transition$.params().personId);
    }
  }
}
```

The URL will reflect the current `personId` parameter value, e.g., `/people/21`
{: .notice--info}

The resolve delegates to PeopleService to fetch the correct person.
It passes the `personId` parameter, which it received from the `$transition$` object.
The `$transition$` is a special injectable object with information about the current state transition.
{: .notice--info}

### Linking with params

Note that our app's main Navigation Bar links to three states: `hello`, `about`, and `people`,
but it doesn't include a link directly to the `person` state.
This is because the state cannot be activated without a parameter value for the `personId` parameter.

In the `people` state we create links to the `person` state.
We create a link for each person in the `people` list.
We still create the link using `ui-sref`, but we include the `personId` parameter value.
As we `ng-repeat` over each person object, we use the object's `.id` property in the `ui-sref`.

{% raw %}
```js
  <li ng-repeat="person in $ctrl.people">
    <a ui-sref="person({ personId: person.id })">
      {{person.name}}
    </a>
  </li>
```
{% endraw %}

To pass parameters to a state using `ui-sref`, add parenthesis after the state name.  
An expression string inside the parenthesis is used as the target state parameter key/value pairs.
The expression is evaluated against the enclosing scope.
{: .notice--info}


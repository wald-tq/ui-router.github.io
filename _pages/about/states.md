---
title: "About States"
layout: single
excerpt: ""
sitemap: true
permalink: /about/states
---

The basic building block of a ui-router application is a state.  A ui-router state corresponds to a 
"place" in the application in terms of the overall UI and navigation. 
Some examples of states might be "dashboard", "messages", "shoppingcart", or "viewblogpost". 

A state (via it's views) defines how the UI looks and what it does at that "place" in the application.  It 
can define a URL fragment that will be added to the browser's URL when the state is active. It also defines 
the data that the state requires, as well as how to get the data.  

Unlike states in a traditional [*state machine*](https://en.wikipedia.org/wiki/Finite-state_machine),  
UI-Router states can be nested.  A parent state can have multiple children states, forming a hierarchical 
tree of application states.  Often, the child states will render their UI inside a viewport from the parent 
state, forming a hierarchical view tree as well.

Hierarchical states can be used to drill down from a more general feature to more specific one, or to implement
a master/detail pattern.  For instance, you might have a state called "contacts" (which renders a list of contacts), 
and two child states "contacts.contact" (to view a single contact) and "contacts.new" (to create a new contact). 
These substates share a common parent state "contacts" and may inherit data and behavior from the parent.

![a tree of states](/images/about/state-tree.png)

### State Machine and Transitions

UI-Router provides a state machine to transition between application states.  These transitions are essentially 
atomic.  When transitioning from state A to state B, either the *entire transition succeeds* and 
the application's current state is now B, or the *entire transition fails* and the application remains at state A.

Transitions have a lifecycle, and expose hooks for each stage of the lifecycle, which applications can tap into.

To learn more about transition hooks, read the API documentation for IHookRegistry.

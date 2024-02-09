// REACT PRINCIPLES

// When something can be calculated from the existing props or state, don’t put it in state. Instead, Calculate it during rendering
// Avoid: Resetting state on prop change in an Effect
// Only Call Hooks at the Top Level. **Don’t call Hooks inside loops, conditions, or nested functions**
// **Only Call Hooks from React Functions, not js functions**
// No matter how you do it, adjusting state based on props or other state makes your data flow more difficult to understand and debug. Always check whether you can reset all state with a key or calculate everything during rendering instead.
// Is any of my state storing the same information twice? Don’t store derived state. Using id’s is a common workaround. Create a normal variable that will updated itself on every render.
// Avoid: Event-specific logic inside an Effect
  // Outline your components into a hierarchy

// Build a static version of the site first, do the logic later
// Figure out what is the absolute minimum state and complete everything else on demand
// One way data flow: down

// Which are state? Identify the ones that are not:

// Does it **remain unchanged** over time? If so, it isn’t state.
// Is it **passed in from a parent** via props? If so, it isn’t state.
// **Can you compute it** based on existing state or props in your component? If so, it *definitely* isn’t state!
// Figure out what component should own your state
// Never define a comp inside another

// For each piece of state in your application:

/* 1. Identify *every* component that renders something based on that state.
2. Find their closest common parent component—a component above them all in the hierarchy.
3. Decide where the state should live:
   1. Often, you can put the state directly into their common parent.
   2. You can also put the state into some component above their common parent.
   3. If you can’t find a component where it makes sense to own the state, create a new component solely for holding the state and add it somewhere in the hierarchy above the common parent component. */

// Try keeping all your jsx variables in a contained object. Then just use the object props to create your jsx.

//# MISC

// regular variables are recreated (new mem assignment) on every re-render
  // get around this by using useMemo: has dependecy array and only returns a function when those dependencies are updated, otherwise keeps state from last render
// for a child to update a parent’s state, pass down a function for them to use from the parent
  // you can pass it down to the child as a prop
  // convention is for the parent function to be named handleEvent and the child attribute to be named onEvent
  // children in this case are called ‘controlled components’
  // setState function should remain in parent, wrap in a function and pass
// When a list is re-rendered, React takes each list item’s key and searches the previous list’s items for a matching key. (will create or destroy keys on re-render based on whether they existed or not from previous list.

//# HOOKS:

    // Only Call Hooks at the Top Level. Don’t call Hooks inside loops, conditions, or nested functions
    // Only Call Hooks from React Functions, not js functions

// setState is asynchronous. It has a 2nd argument you can use to trigger a function directly after setting the state.
// use useReducer if state has deeply nested objects, PITA to update otherwise
// Is any of my state storing the same information twice? Don’t store derived state. Using id’s is a common workaround. Create a normal variable that will updated itself on every render.

//# CLEAN CODE

// import “prop-types” to check types on variables, avoid wrong typing
// setState: if you need the state variable to modify it, pass it as a parm into an arrow function to get the current value
// if setState is going to be a string, pass an empty string as initial to avoid ‘uncontrolled’ errors
// Never modify state directly, instead, return new arrays/objects
// Only call Hooks **at the top level**. Don’t call Hooks inside loops, conditions, or nested functions.
// Only call Hooks **from React function components**. Don’t call Hooks from regular JavaScript functions. (There is just one other valid place to call Hooks — your own custom Hooks. We’ll learn about them in a moment.)

//# useEFFECT

// runs on every component render unless has array
// runs after the render
// clean up function happens before the use effect
  // also runs when component unmounts too
  // good for preventing state leaks


useEffect( () => {
	// run the effect
return () => cleanup()// clean up function (optional)
}, [stateVarToTrack] )


//# useREF


somethingYouWantToStoreAcrossLifecycle = useRef();

// stays the same across state changes, does not re-render
// must access object through ".current"
//ex:

someRef.current;

// updates syncronously, opp of useState

// you can reference DOM elements directly, which useState cannot do


//# TESTING


// CLI: npm test
// use test.js file extensions
// export functions into test files
// uses Jest library, Testing Library

import { fucntionToTest } from "./functions";

test("name of test", () => {
expect( functionToTest(simpleArgument) ).toBe(expectedAnswerArgument);
}

// testing for a render
import { render } from '@testing-library/react';

test('name of test', () => {
  const { getByText } = render(<App />);
  const h1 = getByText(/This is a test render/);

  expect(h1).toHaveTextContent('This is a test render');
});


//# useContext


// DEFINING CONTEXT create the context and wrapping a component

export const WhateverContext = React.createContext();

const [someGlobalVar, setSomeGlobalVar] = useState('someValue');

return ( // Provider takes one attribue (value)
	<WhateverContext.Provider value={someGlobalVar}>
		<SubComponent />
	</WhateverContext.Provider>
);


// USING CONTEXT using the context in a component
import { useContext, useReducer } from 'react';
import { WhateverContext } from './App'

export function SomeComponent() {
	const globalVarYouNeed = useContext(WhateverConext)
}

// OR use the composition approach with the context in it's own file

import {useContext, useState, createContext } from 'react';

const WhateverContext = React.createContext();


// CREATE A CUSTOM HOOK TO EXPORT THE CONTEXT
import React, { useContext } from 'react'

const WhateverContext = React.createContext();

export function UseWhateverContext() {
    return useContext(WhateverContext)
    // this creates a wrapper for your context which simplifies using it in your children
    // no need to import useContext then
  }

export function WhateverProvider ({ children }) {
	// usestate
	// function to update state
return (
	<WhateverContext.Provider value={[state, setState]}>
		{children}
	</WhateverContext.Provider> // You can wrap multiple contexts if you want.

//  wrap ThemeProvider around anything further up the tree, no attributes needed

import WhateverProvider from './WhateverProvier'

export function App()  {
    return (
      <WhateverProvider>
      <SubComp />
      </WhateverProvider>
    )
  }

// then just import custom hook into child component and destructure as needed

import { useWhateverContext } from './WhateverContext'

export function Child(){
const someChildCompVar = useWhateverContext();

}



//# PROPS

// Props are immutable. Whenever state changes, children request a new prop object, old memory is discarded
// use composition to pass children into the parents (below)


// PROPS FORWARDING
export default function Parent(props) {
	return (
		<div>
			<Child (...props) />
		</div>);
}

// PROP DEFAULTS
function child({ thingWithDefault = true, thingNoDefulat }) {}



// COMPOSITION IN REACT

// give all higher level comps the children as prop and wrap them around all children
// all children will have access to that state, just pass the sat into the child comp in the tree as an attribute
// and also put the state as a prop in the child definition


function Parent({children}) { // Parent takes in children and renders them
		// whatever
return (
	<>
		{children}
	</>
)}

function App() {
	const [state, setState] = useState(null);

	return (
		<Parent>
			<ChildComp state={state} />
		</Parent>
	); // pass the state in whenever a comp needs it
}



// useREDUCER

const initialTodos = [
  {
    id: 1,
    title: "Todo 1",
    complete: false,
  },
  {
    id: 2,
    title: "Todo 2",
    complete: false,
  },
];

const reducer = (state, action) => {
  switch (action.type) {
    case "COMPLETE":
      return state.map(s => s.toUpperCase())
    default:
      throw new Error;
  }
};


const [ state, dispatch ] = useReducer(reducer, initialTodos)

function Todos() {
  const [todos, dispatch] = useReducer(reducer, initialTodos);

  const handleComplete = (todo) => {
    dispatch({ type: "COMPLETE", id: todo.id });
  };

  return (
    <>
      {todos.map((todo) => (
        <div key={todo.id}>
          <label>
            <input
              type="checkbox"
              checked={todo.complete}
              onChange={() => handleComplete(todo)}
            />
            {todo.title}
          </label>
        </div>
      ))}
    </>
  );
}


// REDUX
// state gets defined in reducing declaration. returns state instead of error. 

const reduxReducer = (state = { todo1: {
    id: 1,
      title: "Todo 1",
      complete: false,
  },
    todo2: {
      id: 2,
      title: "Todo 2",
      complete: false,
    },

  }, action) => {
  switch (action.type) {
    case "COMPLETE":
      return state.map(s => s.toUpperCase())
    default:
      return state;
  }
};

import { createStore } from "redux"
import { Provider, useSelector, useDispatch } from "react-redux"

const store = createStore(reduxReducer)

const dispatch = useDispatch()
const todo = useSelector(state => state.todo1)  // grab whatever state you want

export default () => <Provider store={store}><App /></Provider>




//# CSS

//## Utility (tailwind)

// you can make them reusable using import tx from twin.macro
// you can even use tailwind inside styled components:


import tw, { styled } from twin.macro

const BigText = styled.h1`
	${tw`text-5xl text-blue-700`}
`

const example = () => <BigText>This is an H1</BigText>


//## Modules

// They are locally scoped. Import a file as a ‘styles’ variable. Then call styles.classWhatever in className. import styles from ‘./cssmodules.module.css’
// create and import a module for each component
// has a composes function for overrides

//## Styled Components / Emotion

// declare styles in a const right in the component file
// capable of nesting css
// can write normal css in React
// CSSinJS is not as performant
  // can use libs like linaria to compile it down to css
// you can write in css syntax css={css``} or js object literal syntax css={{ }}


import styled from 'styled-components';

const StyledDiv = styled.div`
  color: white;
  background: black;
  p {
    color: green;
  }
`;

const CSSinJs = () => {
  <StyledDiv font="blue">
    <p>This is a styled div using styled components</p>
  </StyledDiv>;
};



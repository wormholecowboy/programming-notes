// MISC
// Never mutate state, always copy


// STORE
store.dispatch(action)
store.getState()
// Store enhancers are wrapper fns that wrap the store and give extra functionality
//     use 'compose' to put multi together and pass into createStore
// Store can have listeners, uses sub/pub model. Sub returns a unsub fn. 
//     listeners run a function after store update.
//     const unsub = store.subscribe(callback)


// MIDDLEWARE
// Customizes how dispatch behaves

const middlewareEnhancer = applyMiddleware(print1, print2, print3)
// Pass enhancer as the second arg, since there's no preloadedState
const store = createStore(rootReducer, middlewareEnhancer)

// Redux middleware are written as a series of three nested functions.
// Middleware written as ES5 functions

// Outer function, next is the next middleware or dispatch if none
function exampleMiddleware(storeAPI) {
  return function wrapDispatch(next) {
    return function handleAction(action) {
      // Do anything here: pass the action onwards with next(action),
      // or restart the pipeline with storeAPI.dispatch(action)
      // Can also use storeAPI.getState() here

      return next(action)
    }
  }
}

// es6 version
const anotherExampleMiddleware = storeAPI => next => action => {
  // Do something in here, when each action is dispatched
  return next(action)
}


// REACT
// useSelector gets the state; accepts a single function, which we call a selector function.
// A selector is a function that takes the entire Redux store state as its argument, reads some value from the state, and returns that result.
// automatically subs comp to the store
const selectTodos = state => state.todos
const todos = useSelector(selectTodos)

const dispatch = useDispatch()
dispatch({ type: 'todos/todoAdded', payload: trimmedText })

// be careful about returning objects with new refs, will re-render unnecessarily. useSelector takes 2nd arg to compare actual changes. Use React's shallowEqual. 






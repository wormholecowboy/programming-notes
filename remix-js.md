# Remix.js

Created: July 28, 2022 8:44 AM
Updated: July 28, 2022 7:47 PM

MISC

- <Outlet /> will import whatever route module you are on into the root layout
- To nest routes under a certain page, create a folder with the same name as the parent route. Put your files in there to be nested and render the parent component with children. 

Make sure to put the <Outlet /> in the parent where you want children to render.  

Put an index.jsx in the folder for you main parent route

```jsx
// IMPORTING CSS 

import { Links } from 'remix'
import globalStylesUrl from '~/styles/global.css'

export function links = () => ({ rel: 'stylesheet', href: globalStylesUrl})
// this will go in any route and select the stylesheet you want

<head>
	<Links />
```

```jsx
// IMPORTING META

import { Meta } from 'remix'
import globalStylesUrl from '~/styles/global.css'

export function meta = () => {
	const keywords = ''
	const desc = ''

	return {
		keywords,
		desc
		}
}

<head>
	<Meta />
```

```jsx

// Linking internally
import {Link} from 'remix'

<Link to='/some/route' className='blah'> </Link>
```
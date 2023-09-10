# TailwindCSS

Created: July 30, 2022 8:02 AM
Updated: October 2, 2022 12:23 PM

MISC

- for custom values in a prop use brackets around prop :`font-size-[23px]`
- Tailwind uses a fixed division of 16 across the viewport
- you can create custom classes in index.css
- use ‘groups’ to tie together behavior from parent and children (doesn’t work with @apply)
    - apply `group` to the parent, `group-hover:text-black` to the child
- dark mode has 2 options set in config, `media or class`
    - media uses browser setting
    - class uses a designated dark class

BASICS

`m mt mb ml mr` `mx my`

`padding same`

`bg-white`

`text-black`

`shadow`

`hover:text-white`

-FLEX

`flex flex-col flex-row`

- full height: `h-screen`
- 

-CUSTOM COLORS

```jsx
// inside config file

{
theme: {
	extend: {
		colors: {
				primary: '#041234',
				secondary: '#123412',
				gray: colors.warmGray // remap
				// or
				black: {
				100: //
				200: // etc.

}

}

// can also remap standard colors by importing
require('tailwindcss/colors')
```

-CUSTOM CLASSES

```css
/* put this in your index.css with the main utility classes */

@layer components {

	.some-custom-class {
		@apply relative flex item-center h-12 w-24;
	}
}
```
# CSS Flex

Created: January 27, 2022 6:14 PM
Updated: May 28, 2022 1:07 PM

<aside>
💡 MISC

</aside>

- better for small layouts and components (use GRID for big layouts)
- main axis = horizontal
- cross axis = vertical

```css
.container{
	display: flex /* or inline-flex 
	
		main axis – The main axis of a flex container is the primary axis along which flex items are laid out. Beware, it is not necessarily horizontal; it depends on the flex-direction property (see below).
    main-start | main-end – The flex items are placed within the container starting from main-start and going to main-end.
    main size – A flex item’s width or height, whichever is in the main dimension, is the item’s main size. The flex item’s main size property is either the ‘width’ or ‘height’ property, whichever is in the main dimension.
    cross axis – The axis perpendicular to the main axis is called the cross axis. Its direction depends on the main axis direction.
    cross-start | cross-end – Flex lines are filled with items and placed into the container starting on the cross-start side of the flex container and going toward the cross-end side.
    cross size – The width or height of a flex item, whichever is in the cross dimension, is the item’s cross size. The cross size property is whichever of ‘width’ or ‘height’ that is in the cross dimension.

	 PARENT PROPERTIES */
		flex-direction: row | row-reverse | column | column-reverse 
			/* establishes main axis*/
		flex-wrap: nowrap | wrap | wrap-reverse;
		flex-flow: column wrap; /* shorthand

		NOTE: reverse will also reverse things in justify-content!!!
		NOTE: changing to a column reverses justify-content and align-items!!! */
		
		justify-content: ; /* defines alighment along main 
			flex-start
			flex-end
			center
			space-evenly
			space-around
			space-between */

		align-items: ; /* defines alignment along cross
			flex-start
			flex-end
			center
			baseline
			stretch */

		align-content: ; /* aligns items along cross in multi-line, wrapped scenarios
			flex-start
			flex-end
			center
			space-around
			space-between */

		gap: ; row-gap: ; column-gap: ; /* greats gutters inside, NOT outside! */
		
		/* CHILD PROPERTIES */

.item {

		order: ; /* use pos and neg numbers to shift items back and forth */
		flex-grow: 1; /* grows items relative to each other ex. 2 is 2x the size of others */
		flex-shrink: 1; 
		flex-basis: 100; /* basically works like min-width as you scale down, pixels or ems */
		flex: grow, shrink, basis; /*shorthand*/
		align-self: auto | flex-start | flex-end | center | baseline | stretch;
			/* overrides default alignment */

}
```

run your CSS through Autoprefixer, which handles the fallbacks very well.

[https://github.com/postcss/autoprefixer](https://github.com/postcss/autoprefixer)

CHEATSHEETS

![flexbox cheatsheet.png](CSS%20Flex%2051393067657549369fc10abceb5b38e0/flexbox_cheatsheet.png)
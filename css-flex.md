
```css
.container{
		flex-direction: row | row-reverse | column | column-reverse 
		flex-wrap: nowrap | wrap | wrap-reverse;
		flex-flow: column wrap; /* shorthand
		
		justify-content: ; /* defines alighment along main */
			flex-start
			flex-end
			center
			space-evenly
			space-around
			space-between

		align-items: ; /* defines alignment along cross */
			flex-start
			flex-end
			center
			baseline
			stretch

		align-content: ; /* aligns items along cross in multi-line, wrapped scenarios */
			flex-start
			flex-end
			center
			space-around
			space-between 

		gap: ; row-gap: ; column-gap: ; /* greats gutters inside, NOT outside! */
		
		/* CHILD PROPERTIES */

.item {

		order: ; /* use pos and neg numbers to shift items back and forth */
		flex-grow: 1; /* grows relative to the space left. 0 is no grow. */ 
		flex-shrink: 1; /* use 0 for no shrinking */ 
		flex-basis: 100; /* use a starting basis for shrinking and growing */
		flex: grow, shrink, basis; /*shorthand*/
		align-self: auto | flex-start | flex-end | center | baseline | stretch;
			/* overrides default alignment */

}
```

run your CSS through Autoprefixer, which handles the fallbacks very well.
[https://github.com/postcss/autoprefixer](https://github.com/postcss/autoprefixer)



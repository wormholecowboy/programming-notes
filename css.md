# CSS

GOTCHAS

- to use relative height, width, the parents must be explicitly defined
advanced stuff: [https://moderncss.dev/guide-to-advanced-css-selectors-part-two/](https://moderncss.dev/guide-to-advanced-css-selectors-part-two/)


SELECTING

- margin, padding, background, text-decoration, text-transform, text align, width, display, list-style, max/min-width, line-height, background-size:cover,
- Syntax differences
    - main h1: selects h1's inside of main, regardless of depth
    - main > h1: selects only the direct descendant h1s (depth = 1)
    - main, h1: selects h1's and main
    - main.class: selects main with this class
    - main.class1.class2:  has both classes
    - main .class: selects tags INSIDE main with this class, regardless of depth
    - div#nav *:  matches anything inside the div
    - p+h1: selects h1 if it comes right after p. need same parent.
    - p~h1: selects h1 if it is preceded anywhere by p. need same parent.
    - input[name="consent"]:checked   selects if is checked
    - p:first-child     selects the first p of its siblings 


## attribute selector
[attribute]	[target]	Selects all elements with a target attribute
[attribute=value]	[target="_blank"]	Selects all elements with target="_blank"
[attribute~=value]	[title~="flower"]	Selects all elements with a title attribute that contains a space-separated list of words, one of which is "flower"
[attribute|=value]	[lang|="en"]	Selects all elements with a lang attribute value starting with "en"
[attribute^=value]	a[href^="https"]	Selects all <a> elements with a href attribute value starting with "https"
[attribute$=value]	a[href$=".pdf"]	Selects all <a> elements with a href attribute value ending with ".pdf"
[attribute*=value]	a[href*="w3schools"]	Selects all <a> elements with a href attribute value containing the substring "w3schools"


# MISC 
- clear:both  —  clears a float
- float: moves an element around
- overflow: controls spillout
- transition: where seconds type(ease-in)
- position & top,down, left, right
    - static is default
    - fixed: is based on where it sits in the viewport (will NOT move other tags) (will NOT scroll)
        - relative to viewport
    - relative: moves element relative to where the element sits in document originally (elements will scroll w. everything else)(will NOT move other tags)
        - relative to it's own position
    - absolute: must go inside a tag that is fixed or relative. Allows you to position it relative to it's container (ex. you can push it 10px down from a div)
        - relative to container
    - fixed and relative take the element out of the flow (don't push around other elements like margins)
- * {margin: 0; padding 0} to scrape browser formatting
- tag:nth-child()    selects the n child inside a parent (ex. table cells in a table: td:nth-child(1))
- z-index: sets the stacking order of fixed elements like divs, highest number is on top
- parallax: background-attachment: fixed
- display:table allows you to treat layout as a table, creates columns for your layout
    - display:table-cell
    - vertical-align:top, center, bottom
    - Essentially, turn your main div into a table, and your column divs into table-cells
    

MEDIA QUERIES

```html
<!-- Make it responsive -->

@media screen and (m-width) { tag {}}
@media print { tag {}}
```

BOILERPLATE

```css
/* boiler plate */

* {margin: 0px;}
nav {display: block;}
main {
  margin: 10px auto; width: 600px; padding: 30px;  margin-top: 0px; 
  background-color: whitesmoke; display: block;
}
```

```html
<--! set the page so that mobile doesn't zoom out on a responsive site -->

<meta name="viewport" content="width=device-width, initial-scale=1.0">
```

CENTERING

Margin auto vs. text-align center: text align if for the content within, margin is for the element itself

MISC

- Rem is good for margin and padding
- Use hsl over hex or rgb
- Use scroll-padding if a sticky header is getting in the way

```css
/* The perfect paragraph width -- ch = character width */

p {
	width: clamp(45ch, 50%, 75ch);	
}
```

UNITS

em: relative to parent (good for scaling things other than fonts)

rem: relative to root (root is typically 16)

fr: fractional (ex. 1fr 1fr 1fr 3fr) (can ONLY be used in grid and flex)

vw, vh: percentage of window

%: based on parent

CLAMP

```css
/* The clamp() function can be used anywhere a <length>, <frequency>,
 <angle>, <time>, <percentage>, <number>, or <integer> is allowed. */

font-size: clamp(min, middle, max);

.el {
  /* Note we're always using a relative unit somewhere
     so that zooming stays effective. */
  font-size: clamp(0.9rem, 1vw + 1rem, 2.2rem);
}
```

VARIABLES - CUSTOM PROPERTIES

```css
/* 
var(<--value>, <optional fallback value>)

Global variable declarations */
:root {
  --blue: #1e90ff;
  --white: #ffffff;
}

/* Local */
.someClass {
  --blue: #1e90ff;
  --white: #ffffff;
}

h1 {
	color: var(--blue);
}
```

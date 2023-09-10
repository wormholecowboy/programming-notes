# CSS Grid

Created: January 27, 2022 6:14 PM
Updated: July 29, 2022 8:41 AM

responsive grid links:

[https://css-tricks.com/responsive-grid-magazine-layout-in-just-20-lines-of-css/](https://css-tricks.com/responsive-grid-magazine-layout-in-just-20-lines-of-css/)

[https://css-tricks.com/look-ma-no-media-queries-responsive-layouts-using-css-grid/](https://css-tricks.com/look-ma-no-media-queries-responsive-layouts-using-css-grid/)

Define a container element as a grid with display: grid, 

set the column and row sizes with grid-template-columns and grid-template-rows, 

and then place its child elements into the grid with grid-column and grid-row.

```css
.container {
  display: grid | inline-grid;
	grid-template-columns: 200px 300px 200px; 
	grid-template-rows: 150px 150px;
/* This create a grid with 3 columns, the middle is 300px. You can use px, rems, ems, fr, etc. */

	grid-auto-rows: 200px;
/* If no "grid-template-rows" defined, makes all rows this size. If combined, applies to all not defined */

	grid-template-columns: repeat(3, 20px) /* Creates 3 columns, 20px wide*/

	grid-auto-rows: minmax(150px, auto) /* Sets the min to 150 and max to auto */

	grid-row-gap: 10px;
	grid-column-gap: 10px;
	grid-gap: 10px; /* does both */
	
}

.grid-item-1 {
	grid-column: 1 / 3; /* This will select the first 2 columns */

	grid-column: 1 / -1; /* This will span across the entire column grid */

	grid-row: 2 / 4;

	/* Alternatively, you can use the span syntax to span columns or rows */
	grid-column: span 3; 
}
```

# Main Grid Shorthand

The following two code blocks are equivalent:

```css
.container {
  grid: auto-flow dense 100px / 1fr 2fr;
}

.container {
  grid-auto-flow: row dense;
  grid-auto-rows: 100px;
  grid-template-columns: 1fr 2fr;
}
```

# Aligning Grid Items

`justify-items` and `justify-self` align items along the row axis, and `align-items` and `align-self` align items along the column axis.

# Align on a Row

```css
.container {
  justify-items: start | end | center | stretch;
}
```

![Untitled](CSS%20Grid%20fe5f3bfd053549ecb65d6ceed602563c/Untitled.png)

# Align on a Column

```css
.container {
  align-items: start | end | center | stretch;
}
```

![Untitled](CSS%20Grid%20fe5f3bfd053549ecb65d6ceed602563c/Untitled%201.png)

## Shorthand for above

```css
.center {
  display: grid;
  place-items: center;
}
```

# Justify Content: grid is less than size of container

```css
.container {
  justify-content: start | end | center | stretch | space-around | space-between | space-evenly;
}
```

![Untitled](CSS%20Grid%20fe5f3bfd053549ecb65d6ceed602563c/Untitled%202.png)

# Align Content: grid is less than size of container

```css
.container {
  align-content: start | end | center | stretch | space-around | space-between | space-evenly;
}
```

![Untitled](CSS%20Grid%20fe5f3bfd053549ecb65d6ceed602563c/Untitled%203.png)

## Shorthand for above

```css
.center {
  display: grid;
  place-content: center;
}
```

# Child Properties

### Spanning columns & rows

```css
.item {
  grid-column: <start-line> / <end-line> | <start-line> / span <value>;
  grid-row: <start-line> / <end-line> | <start-line> / span <value>;
}
```

Example:

```css
.item-c {
  grid-column: 3 / span 2;
  grid-row: third-line / 4;
}
```

![Untitled](CSS%20Grid%20fe5f3bfd053549ecb65d6ceed602563c/Untitled%204.png)

```css
.item {
  justify-self: start | end | center | stretch;
}
```

```css
.item {
  align-self: start | end | center | stretch;
}
```

Shorthand ⬆️

```css
.item-a {
  place-self: center stretch;
}
```

# MISC

- This is good to remember: grid items can be flex parents.
- Grid lines can be named when defining the grid with the grid-template-rows and grid-template-columns properties. Line names can then be referenced to position grid items.
- Like grid line names, grid areas can also be named with the grid-template-areas property. Names can then be referenced to position grid items.
- Grid items can be layered/stacked by properly positioning them and assigning z-index when necessary.
- Firefox supports subgrids
- Implicit tracks get created when there are more grid items than cells in the grid or when a grid item is placed outside of the explicit grid. (See Auto)
- responsive columns:
    
    ```css
    .grid {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
      /* This is better for small screens, once min() is better supported */
      /* grid-template-columns: repeat(auto-fill, minmax(min(200px, 100%), 1fr)); */
      gap: 1rem;
    }
    ```
    
- Autoflow:
    
    ```css
    .container {
      grid-auto-flow: row | column | row dense | column dense;
    }
    
    ```
    

# Grid Area

grid-area: grid-row-start, grid-column-start, grid-row-end, followed by grid-column-end.

![Untitled](CSS%20Grid%20fe5f3bfd053549ecb65d6ceed602563c/Untitled%205.png)

# Grid Template Area (Avoid: I dont like this method)

```
.item-a {
  grid-area: header;
}
.item-b {
  grid-area: main;
}
.item-c {
  grid-area: sidebar;
}
.item-d {
  grid-area: footer;
}

.container {
  display: grid;
  grid-template-columns: 50px 50px 50px 50px;
  grid-template-rows: auto;
  grid-template-areas:
    "header header header header"
    "main main . sidebar"
    "footer footer footer footer";
}
```

![Untitled](CSS%20Grid%20fe5f3bfd053549ecb65d6ceed602563c/Untitled%206.png)

If the name of your grid area is ***foo***, the name of the area’s starting row line and starting column line will be ***foo*-start**, and the name of its last row line and last column line will be ***foo*-end**.

CHEATSHEETS

![grid cheatsheet.jpg](CSS%20Grid%20fe5f3bfd053549ecb65d6ceed602563c/grid_cheatsheet.jpg)
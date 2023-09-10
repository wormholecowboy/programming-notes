# The Pragmatic Programmer

Created: August 23, 2022 9:58 PM
Updated: September 23, 2022 7:35 PM

# 1) pragmatic philosophy

- Don’t live with broken windows
- Make stone soup first, then pull resources in through their curiosity
- Always zoom out and take in the bigger picture
- Require the quality-level up front. Involve users early.
- Treat your knowledge portfolio like an investment portfolio
    - Read a tech book per month
    - Learn a new language per year
    - Meet other devs in other tech
    - Cross pollination is the goal
    - Think critically about all input
        - 5 whys
        - Who does this benefit?
        - Whats the context?
        - When or where would this work?
        - Why is this a problem?
- 

# 2) the pragmatic approach

- Good design adapts to its users, ETC: easier to change
    - Create the habit of asking yourself, is what I just coded easier or harder to change in this system?
- DRY
    - Every piece of knowledge must have one source of truth in a system
    - Ask, does this repetition represent the same knowledge or different?
    - You may choose to break this rule for performance, make sure to keep it localized, such as to just the class
    - Use getters and setters in modules to read and write objects props, keeps them loosely coupled
    - Specify internal apis in a neutral format, with some tool ideally
    - Use something like openapi for external apis
    - Data sources: generate containers from their schema or, better yet, stick all the data in key/value pairs and use a validation table suite to verify it has what u need
    - Keep open communication with devs to avoid interdev duplication. Have a repo for scripts and snippets. Review each others code.
        - Reuse to avoid duplication
- Orthogonality
    - Avoid global data: favor passing context explicitly
    - Avoid duplicate knowledge and functionality; indicates structural problems; look at strategy pattern
    - Develop the habit of being critical of ur code
    - How many source files are affected by bug fixes? Too many?
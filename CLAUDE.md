# Notes format

This folder holds personal reference notes for terminal/vim viewing. Markdown tables render poorly there — **do not use them**.

## Format

- `# SECTION` headers (all caps preferred)
- Each line: `` `command` `` followed by `// comment`
- Two trailing spaces at end of line for a hard line break
- Group related commands under a section; blank line between sections
- No tables, no fluff, no trailing summaries

## Example

```
# BASICS
`ps`              // processes in current shell  
`ps -ef`          // all processes, full format  
`ps aux`          // BSD-style w/ %CPU, %MEM  

# BY PID
`ps -p 1234`            // info on PID 1234  
`ps --ppid 1234`        // children of PID 1234  
```

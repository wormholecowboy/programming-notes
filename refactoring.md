# Refactoring

Created: February 24, 2022 7:10 PM
Updated: February 27, 2022 10:43 AM

PROBLEM: LONG METHOD

- extract method
- IF local variables and params interfere
    
    [Replace Temp Variable with Query](Refactoring%2080d6c822ce5544b69c04292ef1593c79/Replace%20Temp%20Variable%20with%20Query%20144ec8e5b0084224be11a6996ac1f77c.md)
    
    [Introduce Parameter Object](Refactoring%2080d6c822ce5544b69c04292ef1593c79/Introduce%20Parameter%20Object%20e9b864e6be9b457aa4c6f6a793b82f99.md)
    
    - Preserve Whole Object: Pass the whole object instead of certain fields as params
- IF none of the above work, try Replace Method With Method Object
- Conditionals & loops should be moved.
    - Decompose Conditional
    - Extract Method for loops
    

PROBLEM: LARGE CLASS

-
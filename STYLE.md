# Coding Style Guidelines and Contribution Conventions

Since we are developing low-level C, we will loosely adhere to the Linux kernel style.

## Style Guidelines

1. All variable names use `camelCase`.

2. All constants use `ALL_CAPS` with underscores. This includes `enum`.

3. All functions use lowercase separated by underscores: `this_is_some_function(int a, double b, string c)`.

4. Opening brackets for functions will be on the next line of the function signature.

   - Except `do-while`.

5. Never assume the size of data types; use <stdint.h> for precise sizes.

   - e.g. `uint8_t`,

6. Always test for null pointer dereferencing.

## Forbidden Techniques

1. No `malloc`

## Commenting

1. Please adhere to Doxygen style comments.
2. For any function, there should be _at bare minimum_:

   a. The function's purpose. What does it do? Do not write _how_ it works. -> `@brief`.

   b. All function parameters -> `@param a/b/c`.

3. If there is some obscure technique you're trying to implement, writing a comment above it is not a bad idea.
4. Try not to over-comment.
5. At the end of the day, ask yourself if you will remember what this code does in 2 weeks.
   - If the answer is no, either rewrite the function or break it up into smaller functions.
   - Functions should be reusable.

# Coding Style Guidelines and Contribution Conventions

Since we are developing low-level C, we will loosely adhere to the Linux kernel style.

We write good code.

## Style Guidelines

1. All variable names use `camelCase`.
2. All constants use `ALL_CAPS` with underscores.
3. Opening brackets for functions will be on the next line of the function signature.
   - Except `do-while`.
4.

## Forbidden Techniques

1. No `malloc`

## Commenting

1. Please adhere to doxygen style comments.
2. For any function, there should be _at bare minimum_:

   a. The function's purpose. What does it do? Do not write _how_ it works. -> `@brief`.

   b. All function parameters -> `@param a/b/c`.

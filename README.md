# CompArchPrj2
Project from school. Goal was to learn x86 (the basics). You have a file, mystery.s. Figure out what it does. Then, figure out a better way to do it. Rewrite the optimized program x86 (i.e. don't write it in C and output a .s file). 


Spoiler: mystery.s calculates fib n. It does so recursively, which is inefficient because it does several redundant calculations. One optimzation is to store the result fib n-k in an array, which is a performance-enhancing technique called memoization. 

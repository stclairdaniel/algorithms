# LRU Cache

This project incrementally implements an LRU cache in Ruby in 7 phases.

## Static Array

This class just dumbs down a regular Array to be staticly sized.

## Dynamic Arrays
This class implements dynamic arrays from a basic static array. Common array methods, such as push, pop, shift, unshift, and each were all implemented from scratch by using a resize! method that doubles the array length and shifts the elements when capacity is reached.

## Ring Buffer

This class improves upon dynamic arrays by keeping track of a start index and length so that shift and unshift no longer have to move elements, since an element can be appended "before" the start of the array. Push and unshift are O(1) ammortized since we still need a resize! method when the array reaches capacity.

package main

import (
	"C"
	"fmt"
)

//export Fibonacci
func Fibonacci(n C.int) C.int {
	if n <= 1 {
		return n
	}
	return Fibonacci(n-1) + Fibonacci(n-2)
}

func main() {
	num := Fibonacci(40)
	fmt.Println(num)
}

package main

import (
	"flag"
	"fmt"
	"math/rand"
	"time"
)

var seed = rand.New(rand.NewSource(time.Now().UnixNano()))

const asciiLowercase = "abcdefghijklmnopqrstuvwxyz"
const asciiUppercase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
const asciiIntdigits = "0123456789"
const asciiHexdigits = "0123456789abcdef"

func randomString(length int, charset string) string {
	b := make([]byte, length)

	for i := range b {
		b[i] = charset[seed.Intn(len(charset))]
	}

	return string(b)
}

func main() {

	var returnType = flag.String("type", "str", "Type of value to generate: hex, int or str.")
	var returnLength = flag.Int("length", 10, "Result length.")

	flag.Parse()

	var value string

	switch *returnType {
	case "str":
		characters := asciiLowercase + asciiUppercase + asciiIntdigits
		value = randomString(*returnLength, characters)
	case "int":
		value = randomString(*returnLength, asciiIntdigits)
	case "hex":
		value = randomString(*returnLength, asciiHexdigits)
		value = "0x" + value
	default:
		fmt.Printf("Unsuported type: %s\n", *returnType)
		panic("invalid type")
	}

	fmt.Println(value)
}

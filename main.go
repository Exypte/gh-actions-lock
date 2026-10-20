// Binary gh-actions-lock parses YAML files and prints them.
package main

import (
	"os"

	"github.com/Exypte/gh-actions-lock/cmd"
)

func main() {
	if err := cmd.Execute(); err != nil {
		os.Exit(1)
	}
}

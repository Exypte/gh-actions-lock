# AGENTS.md

Instructions for AI coding agents working in this repository.

## Project

`gh-actions-lock` is a Go CLI that parses a YAML file and prints it.

```
main.go                   entry point, calls cmd.Execute
cmd/                      cobra commands (root.go, print.go)
internal/yamlprint/       YAML parsing (via viper) and printing
testdata/                 sample input files
```

## Rules

1. **Code style:** all Go code must follow the Google Go Style Guide:
   https://google.github.io/styleguide/go/guide (including its
   [Decisions](https://google.github.io/styleguide/go/decisions) and
   [Best Practices](https://google.github.io/styleguide/go/best-practices)).
   In particular: short lowercase package names (no `util`/`common`), doc
   comments on every exported identifier starting with its name, lowercase
   error strings without trailing punctuation, errors wrapped with `%w`, no
   panics for ordinary errors, and table-driven tests reporting
   `Func(input) = got, want want` (use `cmp.Diff` for comparisons).
2. **CLI library:** use [cobra](https://github.com/spf13/cobra) for commands,
   flags and arguments. Do not add another CLI library.
3. **Configuration library:** use [viper](https://github.com/spf13/viper) for
   configuration (flags, environment variables, config files) and for parsing
   input YAML files. Do not add another configuration library.

## Commands

Run these before considering a change done:

```sh
gofmt -l .        # must print nothing
go vet ./...
go build ./...
go test ./...
```

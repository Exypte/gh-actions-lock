# gh-actions-lock

A small CLI that parses a YAML file and prints it.

## Usage

```sh
go run . print testdata/example.yaml
go run . print testdata/example.yaml --indent 4
```

The file is parsed with viper, so map keys are printed lowercased and in
alphabetical order, and comments are dropped.

## Configuration

| Setting  | Flag       | Environment variable     | Default |
|----------|------------|--------------------------|---------|
| `indent` | `--indent` | `GH_ACTIONS_LOCK_INDENT` | `2`     |

Settings can also be put in a YAML config file passed with `--config`, or in
`.gh-actions-lock.yaml` in the current directory or `$HOME`:

```yaml
indent: 4
```

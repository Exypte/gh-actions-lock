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

## GitHub Actions workflow lockfiles

[Github blog](https://github.blog/changelog/2026-10-14-github-actions-workflow-lockfiles-in-public-preview/)

[gh-actions-lock](https://github.com/github/gh-actions-lock)

[Article about the tool](https://labs.boostsecurity.io/articles/pinning-the-unpinnable-github-actions-lockfiles/)

### Maintenance nightmare

```yaml
    # Before
    - uses: actions/checkout@d23441a48e516b6c34aea4fa41551a30e30af803 # v6.1.0

    # After
    - uses: actions/checkout@v6.1.0
```

### Now

A simple workflow :

```yaml
name: Go

on:
  push:
    branches: [ "main" ]
  pull_request:
    branches: [ "main" ]

jobs:

  build:
    runs-on: ubuntu-latest
    steps:
    - uses: Exypte/print-version@main
    
    - uses: Exypte/print-version@test
    
    - uses: actions/checkout@v6.1.0

    - name: Setup Go
      uses: actions/setup-go@v5.6.0
      with:
        go-version: '1.27.2'
        
    - name: Install dependencies
      run: go get .
      
    - name: Build
      run: go build -v ./...

    - name: Test
      run: go test -v ./...
```

The corresponding commit pins live in the [actions.lock](.github/workflows/actions.lock) :

```yaml
version: 'v0.0.3'
workflows:
    '.github/workflows/go.yml':
        - 'actions/checkout@v6.1.0'
        - 'actions/setup-go@v5.6.0'
        - 'exypte/print-version@main'
        - 'exypte/print-version@test'
dependencies:
    'actions/checkout@v5':
        ref: 'v5'
        commit: 'sha1-fbc6f3992d24b796d5a048ff273f7fcc4a7b6c09'
        owner_id: 44036562
        repo_id: 197814629
    'actions/checkout@v6.1.0':
        ref: 'v6.1.0'
        commit: 'sha1-d23441a48e516b6c34aea4fa41551a30e30af803'
        owner_id: 44036562
        repo_id: 197814629
    'actions/setup-go@v5.6.0':
        ref: 'v5.6.0'
        commit: 'sha1-40f1582b2485089dde7abd97c1529aa768e1baff'
        owner_id: 44036562
        repo_id: 192624594
    'exypte/print-version@main':
        ref: 'main'
        commit: 'sha1-4e61187d907d6708fd223b32dc479661a7efa5ef'
        owner_id: 38421281
        repo_id: 1427066307
    'exypte/print-version@test':
        ref: 'test'
        commit: 'sha1-0d02384b7615759a4f721423a79e505cced44466'
        owner_id: 38421281
        repo_id: 1427066307
        uses:
            - 'actions/checkout@v5'
```


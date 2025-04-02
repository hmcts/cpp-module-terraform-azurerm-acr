## Requirements

Terratest uses the Go testing framework. To use Terratest, you need to install:

    Go (requires version >=1.21.1)

## Info
Utilises Examples and tests folder

1) To configure dependencies, run:
    (where module name is the name of your module -check go.mod)
    cd test
    go mod init "<MODULE_NAME>"
    go mod tidy

2) To run the tests:

    cd test
    go test -v -timeout 30m


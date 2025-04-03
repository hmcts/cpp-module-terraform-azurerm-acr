## Requirements

Terratest uses the Go testing framework. To use Terratest, you need to install:

    Go (requires version >=1.21.1)

## Info
Utilises Examples and tests folder
Subscription ID below useful for local testing
export ARM_SUBSCRIPTION_ID="e6b5053b-4c38-4475-a835-a025aeb3d8c7" 

1) To configure dependencies, run:
    (where module name is the name of your module -check go.mod)
    cd test
    go mod init "<MODULE_NAME>"
    go mod tidy

2) To run the tests:

    cd tests/terratest
    go test -v -timeout 30m

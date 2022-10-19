package test

import (
	"path/filepath"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	test_structure "github.com/gruntwork-io/terratest/modules/test-structure"
	"github.com/stretchr/testify/assert"
)

//Testing the secure-file-transfer Module
func TestAzureACR(t *testing.T) {
	t.Parallel()

	// Terraform plan.out File Path
	exampleFolder := test_structure.CopyTerraformFolderToTemp(t, "../..", "example")
	planFilePath := filepath.Join(exampleFolder, "plan.out")

	terraformPlanOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../example",
		Upgrade:      true,

		// Variables to pass to our Terraform code using -var options
		VarFiles: []string{"terratest.tfvars"},

		//Environment variables to set when running Terraform

		// Configure a plan file path so we can introspect the plan and make assertions about it.
		PlanFilePath: planFilePath,
	})

	// Run terraform init plan and show and fail the test if there are any errors
	terraform.InitAndPlanAndShowWithStruct(t, terraformPlanOptions)

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformPlanOptions)

	// Run `terraform init` and `terraform apply`. Fail the test if there are any errors.
	terraform.InitAndApply(t, terraformPlanOptions)

	// Run `terraform output` to get the values of output variables
	RG := terraform.Output(t, terraformPlanOptions, "ACR-RG-LAB")

	// Assert statements
	assert.Equal(t, RG, "ACR-RG-LAB")

}

package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/azure"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"

	test_structure "github.com/gruntwork-io/terratest/modules/test-structure"
)

func TestTerraformAcr(t *testing.T) {
	t.Parallel()

	// Terraform plan.out File Path
	fixtureFolder := "../../examples/"
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: fixtureFolder,
		Upgrade:      true,
		// Variables to pass to our Terraform code using -var options
		VarFiles: []string{"for_terratest.tfvars"},

		//Environment variables to set when running Terraform

		// Configure a plan file path so we can introspect the plan and make assertions about it.
		// PlanFilePath: planFilePath,
	})

	// This will init and apply the resources and fail the test if there are any errors
	// return stdout/stderr from the apply command.
	_, err := terraform.InitAndApplyE(t, terraformOptions)
    if err != nil {
        t.Fatal("Terraform InitAndApply failed:", err)
    }

	// Run `terraform output` to get the values of output variables
	registryName := terraform.Output(t, terraformOptions, "acr_name")
	resourceGroupName := terraform.Output(t, terraformOptions, "resource_group_name")
	subscriptionID := terraform.Output(t, terraformOptions, "subscription_id")

	// Assert statements
	assert.True(t, azure.ContainerRegistryExists(t, registryName, resourceGroupName, subscriptionID))
	assert.Equal(t, registryName, "ACRTERRAREPO01")

	// When the test is completed, teardown the infrastructure by calling terraform destroy
	test_structure.RunTestStage(t, "teardown", func() {
		terraformOptions := test_structure.LoadTerraformOptions(t, fixtureFolder)
		terraform.Destroy(t, terraformOptions)
	})
}

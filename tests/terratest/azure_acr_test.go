package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/azure"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestTerraformAcr(t *testing.T) {
	t.Parallel()

	// Terraform plan.out File Path

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../../examples/",
		Upgrade:      true,
		// Variables to pass to our Terraform code using -var options
		VarFiles: []string{"for_terratest.tfvars"},

		//Environment variables to set when running Terraform

		// Configure a plan file path so we can introspect the plan and make assertions about it.
		// PlanFilePath: planFilePath,
	})

	// Defer the destroy to cleanup all created resources
	defer terraform.Destroy(t, terraformOptions)

	// This will init and apply the resources and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

	// Run `terraform output` to get the values of output variables
	registryName := terraform.Output(t, terraformOptions, "acr_name")
	resourceGroupName := terraform.Output(t, terraformOptions, "resource_group_name")
	subscriptionID := terraform.Output(t, terraformOptions, "subscription_id")

	// Assert statements
	assert.True(t, azure.ContainerRegistryExists(t, registryName, resourceGroupName, subscriptionID))
	assert.Equal(t, registryName, "ACRTERRAREPO01")
}

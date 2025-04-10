package test

import (
	"strings"
	"testing"

	"github.com/gruntwork-io/terratest/modules/azure"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestTerraformAcr(t *testing.T) {
	t.Parallel()

	uniquePostfix := strings.ToLower(random.UniqueId())

	// Terraform plan.out File Path
	fixtureFolder := "../../examples/"

	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: 			fixtureFolder,
		Upgrade:      			true,
		// Variables to pass to our Terraform code using -var options
		VarFiles: 				[]string{"for_terratest.tfvars"},
		SetVarsAfterVarFiles: 	true,
		Vars: 					map[string]interface{}{
									"postfix": uniquePostfix,
								},
	}

	//destroy at when tests finish
	defer terraform.Destroy(t, terraformOptions)

	// Triggers the terraform init and terraform apply command
	// This will init and apply the resources and fail the test if there are any errors
	// return stdout/stderr from the apply command.
	_, err := terraform.InitAndApplyE(t, terraformOptions)
	if err != nil {
		t.Fatal("Terraform ApplyE failed:", err)
	}

	// Run `terraform output` to get the values of output variables
	registryName := terraform.Output(t, terraformOptions, "acr_name")
	resourceGroupName := terraform.Output(t, terraformOptions, "resource_group_name")
	subscriptionID := terraform.Output(t, terraformOptions, "subscription_id")

	// Assert statements
	assert.True(t, azure.ContainerRegistryExists(t, registryName, resourceGroupName, subscriptionID))

}

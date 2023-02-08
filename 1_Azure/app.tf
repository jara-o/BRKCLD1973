# Create the resource group
resource "azurerm_resource_group" "rg" {
  name     = "${var.env}-rg"
  location = "${var.rg_location}"
}

# Create the Linux app service plan
resource "azurerm_service_plan" "appserviceplan" {
  name                = "${var.env}-serviceplan"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "${var.os_type}"
  sku_name            = "${var.sku_name}"
}

# Create the web app
resource "azurerm_linux_web_app" "webapp" {
  name                                = "${var.env}-app"
  location                            = azurerm_resource_group.rg.location
  resource_group_name                 = azurerm_resource_group.rg.name
  service_plan_id                     = azurerm_service_plan.appserviceplan.id
  https_only                          = true
  app_settings = {
    "SCM_DO_BUILD_DURING_DEPLOYMENT"  = "1"
  }
  site_config { 
    minimum_tls_version               = "1.2"
    application_stack {
        python_version                = "${var.python_version}"
    }
  }
}

#  Deploy code from public GitHub repo
resource "azurerm_app_service_source_control" "sourcecontrol" {
  app_id                  = azurerm_linux_web_app.webapp.id
  repo_url                = "${var.github_repo_url}"
  branch                  = "${var.github_branch}"
  use_manual_integration  = false
  use_mercurial           = false
}
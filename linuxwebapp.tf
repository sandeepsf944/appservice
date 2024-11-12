resource "azurerm_linux_web_app" "example" {
  name                = lower(var.linux_web_app_name)
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  service_plan_id     = azurerm_service_plan.example.id
  #here service plan id automatically took

  app_settings = merge({ SCM_DO_BUILD_DURING_DEPLOYMENT = true }, var.app_settings)


  site_config {
    app_command_line                  = var.app_startup_command
    ftps_state                        = var.ftps_state
    scm_ip_restriction_default_action = var.scm_ip_restriction_default_action
    ip_restriction_default_action     = var.ip_restriction_default_action
    #ip_restriction_default_action make deny if you want to allow only below rule

    ip_restriction {
      count = length(new_ip_restriction_list)  
      action     = "Allow"
      headers    = []
      ip_address = element(local.ip_restriction_list, count.index)
      name       = element(distinct(var.restricted_ip_name_list), count.index)
      priority   = 300
    }

    application_stack {
    python_version = lookup(application_stack.value, "python_version", null)
    php_version = lookup(application_stack.value, "php_version", null)
    dotnet_version = lookup(application_stack.value, "dotnet_version", null)
    go_version = lookup(application_stack.value, "go_version", null)
    java_server = lookup(application_stack.value, "java_server", null)
    java_server_version = lookup(application_stack.value, "java_server_version", null)
    java_version = lookup(application_stack.value, "java_version", null)
    node_version = lookup(application_stack.value, "node_version", null)
    ruby_version = lookup(application_stack.value, "ruby_version", null)

    }
  }

  zip_deploy_file = var.zip_deploy_file_path
  webdeploy_publish_basic_authentication_enabled = false
}
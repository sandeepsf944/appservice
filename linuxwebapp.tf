resource "azurerm_linux_web_app" "linux_web_app" {
  name                = lower(var.linux_web_app_name)
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = var.service_plan_id
  #here service plan id automatically took

  app_settings = merge({ SCM_DO_BUILD_DURING_DEPLOYMENT = true }, var.app_settings)

  dynamic "site_config" {
    for_each = [merge(local.default_site_config, var.site_config)]

    content {
      app_command_line                  = var.app_startup_command
      ftps_state                        = var.ftps_state
      scm_ip_restriction_default_action = var.scm_ip_restriction_default_action
      ip_restriction_default_action     = var.ip_restriction_default_action
      # ip_restriction_default_action make deny if you want to allow only below rule
      
      application_stack {
        python_version = var.python_version
        php_version = var.php_version
        dotnet_version = var.dotnet_version
        # go_version = lookup(application_stack.value, "go_version", null)
        # java_server = lookup(application_stack.value, "java_server", null)
        # java_server_version = lookup(application_stack.value, "java_server_version", null)
        # java_version = lookup(application_stack.value, "java_version", null)
        # node_version = lookup(application_stack.value, "node_version", null)
        # ruby_version = lookup(application_stack.value, "ruby_version", null)
        }


      dynamic "ip_restriction" { 
        for_each = range(length(var.new_ip_restriction_list))
        content {
        action     = "Allow"
        headers    = []
        ip_address = var.new_ip_restriction_list[ip_restriction.key]
        name       = var.restricted_ip_name_list[ip_restriction.key]
        priority   = 300
        }
        }
      }
  } 

      zip_deploy_file = var.zip_deploy_file_path
      webdeploy_publish_basic_authentication_enabled = var.webdeploy_publish_basic_authentication_enabled
}
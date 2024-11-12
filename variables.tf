variable linux_web_app_name {
    type = any
}
variable app_settings {
    type = any
    default = {}
} 
variable app_startup_command {
    type = any
}
variable ftps_state {
    type = any
}
variable scm_ip_restriction_default_action {
    type = any
}
variable ip_restriction_default_action {
    type = any
}
variable ip_restriction_list {
    type = any
}
variable restricted_ip_name_list {
    type = any
}
variable zip_deploy_file_path {
    type = any
}

variable php_version {
    type = any
    default = {}
} 
variable python_version {
    type = any
    default = {}
} 
# type = any
# type = list(string)
# type = string
# type = map(any)
variable "app_settings" {
  type    = map(any)
  default = {}
}

variable "ip_restrictions" {
  description = "List of IP restrictions"
  type = list(object({
    action     = string
    headers    = list(string)
    ip_address = string
    name       = string
    priority   = number
  }))
  default = [
    {
      action     = "Allow"
      headers    = []
      ip_address = "0.0.0.0/0"
      name       = "allow-all-public"
      priority   = 300
    }
  ]
}




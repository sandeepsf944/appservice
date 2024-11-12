locals {
  new_ip_restriction_list = distinct(var.ip_restriction_list) 
}
variable "server-config" {
  description = "Map of server configuration"
  type = map(object({
    ami_id =string
    instance_type_val=string
    key_pair_name=string 
  }))
}